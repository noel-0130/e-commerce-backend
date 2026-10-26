class Api::CartsController < ApplicationController
  def create
    user = User.find_by(id: session[:user_id])

    unless user
      return render json: { error: "Not authenticated" },
                    status: :unauthorized
    end

    cart = user.cart || user.create_cart!

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
        cart_item_id: item.id,
        product_id: item.product_id,
        name: item.product.name,
        price: item.product.price,
        stock: item.product.stock,
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