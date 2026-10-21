class Api::CartItemsController < ApplicationController
  before_action :set_cart, only: [:create, :update, :destroy]
  before_action :set_cart_item, only: [:update, :destroy]

  def create
    product = Product.find(cart_items_params[:product_id])

    quantity = cart_items_params[:quantity].to_i

    if quantity <= 0
      return render json: { error: "Quantity must be greater than 0" },
                    status: :unprocessable_content
    end

    cart_item = @cart.cart_items.find_or_initialize_by(product: product)

    if cart_item.new_record?
      cart_item.quantity = quantity
    else
      cart_item.quantity += quantity
    end

    if cart_item.save
      render json: cart_item, status: :created
    else
      render json: { errors: cart_item.errors.full_messages },
             status: :unprocessable_content
    end
  end

  def update
    if params[:action_type].present?
      case params[:action_type]
      when "increase"
        @cart_item.quantity += 1
      when "decrease"
        @cart_item.quantity -= 1
      else
        return render json: { error: "Invalid action" },
                      status: :unprocessable_content
      end
    elsif params[:cart_item].present?
      unless @cart_item.update(cart_items_params)
        return render json: { errors: @cart_item.errors.full_messages },
                      status: :unprocessable_content
      end
    else
      return render json: { error: "Missing quantity or action_type" },
                    status: :unprocessable_content
    end

    if @cart_item.save
      render json: @cart_item, status: :ok
    else
      render json: { errors: @cart_item.errors.full_messages },
             status: :unprocessable_content
    end
  end

  def destroy
    @cart_item.destroy
    head :no_content
  end

  private

  def set_cart
    @cart = Cart.find_by!(
      id: params[:cart_id],
      token: request.headers["X-Cart-Token"]
    )
  end

  def set_cart_item
    @cart_item = @cart.cart_items.find(params[:id])
  end

  def cart_items_params
    params.require(:cart_item).permit(:product_id, :quantity)
  end
end