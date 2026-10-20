class Api::CartsController < ApplicationController
  def create
    cart = Cart.create!

    render json: { id: cart.id }, status: :created
  end

  def show
    cart = Cart.find(params[:id])
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
