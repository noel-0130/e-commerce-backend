class Api::OrdersController < ApplicationController
  before_action :require_user

  def index
    orders = @current_user.orders
                          .includes(:order_items)
                          .order(created_at: :desc)

    render json: orders.map { |order| serialize(order) }
  end

  def show
    order = @current_user.orders.includes(:order_items).find(params[:id])

    render json: serialize(order)
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Order not found" }, status: :not_found
  end

  private

  def require_user
    @current_user = User.find_by(id: session[:user_id])

    return if @current_user

    render json: { error: "Not authenticated" }, status: :unauthorized
  end

  def serialize(order)
    {
      id: order.id,
      order_number: "ORD-#{order.id}",
      customer_name: order.customer_name,
      customer_email: order.customer_email,
      shipping_address: order.shipping_address,
      total_amount: order.total_amount,
      status: order.status,
      created_at: order.created_at,
      items: order.order_items.map do |item|
        {
          product_id: item.product_id,
          name: item.product_name,
          price: item.price,
          quantity: item.quantity,
          subtotal: item.price * item.quantity
        }
      end
    }
  end
end