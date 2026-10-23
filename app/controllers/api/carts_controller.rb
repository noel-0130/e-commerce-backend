class Api::CartsController < ApplicationController
  def create
    user = User.first

    unless user
      return render json: {
        error: "User not found"
      }, status: :unprocessable_entity
    end

    cart = user.create_cart!

    render json: {
      id: cart.id,
      token: cart.token
    }, status: :created
  end

  def show
    cart = Cart.find_by!(
      id: params[:id],
      token: request.headers["X-Cart-Token"]
    )

    items = cart.cart_items.includes(:product)

    formatted_items = items.map do |item|
      {
        product_id: item.product_id,
        name: item.product.name,
        price: item.product.price,
        quantity: item.quantity,
        subtotal: item.product.price * item.quantity
      }
    end

    render json: {
      id: cart.id,
      items: formatted_items,
      total: formatted_items.sum { |item| item[:subtotal] }
    }
  end
end