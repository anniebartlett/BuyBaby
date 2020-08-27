class ProductOrdersController < ApplicationController

  def create
    @order = current_user.orders.find_by(state:"pending") || Order.create(user: current_user, state: "pending")
    @product = Product.find(params[:product_id])
    @order = Order.find(params[:order_id])
    @product_order = ProductOrder.new
    authorize @product_order
    @product_order.order = @order
    @product_order.product = @product
    @product_order.save
    redirect_to products_path
  end

  def destroy
    @product_order = ProductOrder.find(params[:id])
     authorize @product_order
    @product_order.destroy
    redirect_to order_path(@product_order.order)
  end

end
