class ProductOrdersController < ApplicationController

  def create
    @order = current_user.orders.find_by(state:"pending") || Order.create(user: current_user, state: "pending")
    @product = Product.find(params[:product_id])
    @product_order = ProductOrder.new(order: @order, product: @product)
    authorize @product_order
    if @product_order.save
      flash[:notice] = "product added to cart"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "product was not added to cart"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @product_order = ProductOrder.find(params[:id])
    authorize @product_order
    @product_order.destroy
    redirect_to order_path(@product_order.order)
  end
end
