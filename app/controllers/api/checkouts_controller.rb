class Api::CheckoutsController < ApplicationController
  class InsufficientStockError < StandardError
  end

  def create
    cart = Cart.find_by!(id: params[:cart_id], token: request.headers["X-Cart-Token"])
    items = cart.cart_items.includes(:product)

    if items.empty?
      return render json: { error: "Cart is empty" },
                    status: :unprocessable_content
    end

    order = nil

    Order.transaction do
      # Lock products to prevent simultaneous stock deductions.
      products = items.map(&:product).uniq.sort_by(&:id)
      products.each(&:lock!)

      # Validate stock before creating the order.
      items.each do |item|
        if item.quantity > item.product.stock
          raise InsufficientStockError,
                "Insufficient stock for #{item.product.name}"
        end
      end

      # Calculate total and create the order.
      total_amount = items.sum do |item|
        item.product.price * item.quantity
      end

      order = Order.create!(
        customer_name: params[:customer_name],
        customer_email: params[:customer_email],
        shipping_address: params[:shipping_address],
        total_amount: total_amount
      )

      # Create order items and deduct stock.
      items.each do |item|
        order.order_items.create!(
          product: item.product,
          product_name: item.product.name,
          price: item.product.price,
          quantity: item.quantity
        )

        item.product.decrement!(:stock, item.quantity)
      end

      # Clear the cart after successful checkout.
      cart.cart_items.destroy_all
    end

    render json: {
      message: "Checkout successful",
      order_id: order.id,
      total_amount: order.total_amount,
      status: order.status
    }, status: :created

  rescue InsufficientStockError => e
    render json: { error: e.message },
           status: :unprocessable_content

  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages },
           status: :unprocessable_content

  rescue ActiveRecord::RecordNotFound
    render json: { error: "Cart or product not found" },
           status: :not_found
  end
end