class ReviewsController < ApplicationController
  def new
    @product = Product.find(params[:product])
    @user = User.find(params[:user_id])
    @orders = policy_scope(Order)
    @review = Review.new
    authorize @review
  end

  def edit; end

  def create
    @product = Product.find(params[:review][:product])
    @user = User.find(params[:user_id])
    @reviewer = current_user
    @review = Review.new(review_params)
    authorize @review
    @review.user = @user
    if @review.save!
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def show;end


  def destroy
    @review = Review.find(params[:id])
    @user = @review.user
    @review.destroy
    redirect_to user_path(@review.user)
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end
