class Api::CartItemsController < ApplicationController
  def create
    cart = Cart.find(params[:cart_id])
    product = Product.find(cart_items_params[:product_id])

    cart_item = cart.cart_items.find_or_initialize_by(product: product)

    cart_item.quantity = ( cart_item.quantity || 0 ) + cart_items_params[:quantity].to_i

    if cart_item.save
      render json: cart_item, status: :created
    else
      render json: { errors: cart_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    cart = Cart.find(params[:cart_id])
    cart_item = cart.cart_items.find(params[:id])

    if params[:action_type].present?
      case params[:action_type]
      when "increase"
        cart_item.quantity += 1
      when "decrease"
        cart_item.quantity -= 1
      else
        return render json: { error: "Invalid action" },
                      status: :unprocessable_entity
      end
    elsif params[:cart_item].present?
      unless cart_item.update(cart_items_params)
        return render json: { errors: cart_item.errors.full_messages },
                      status: :unprocessable_entity
      end
    else
      return render json: { error: "Missing quantity or action_type" },
                    status: :unprocessable_entity
    end

    if cart_item.save
      render json: cart_item, status: :ok
    else
      render json: { errors: cart_item.errors.full_messages },
            status: :unprocessable_entity
    end
  end

  def destroy
    cart = Cart.find(params[:cart_id])
    cart_item  = cart.cart_items.find(params[:id])

    cart_item.destroy
    head :no_content
  end
  
  private

  def cart_items_params
    params.require(:cart_item).permit(:product_id, :quantity) 
  end
end
