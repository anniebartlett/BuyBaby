class ReviewsController < ApplicationController
  before_action :find_user, except: [:destroy]

  def new
    @user = User.find(params [:user_id])
    @review = Review.new
    authorize @review
  end

  def edit; end

  def create
    @user = Review.find(params[:user_id])
    @review = Review.new(review_params)
    @review.user = @user
    if @review.save
    redirect_to user_path(@user)
  else
    render :new
  end
  end

  def destroy
  @review = Review.find(params[:id])
  @user = @review.user
  @review.destroy
  redirect_to user_path(@review.user)
  end

  private

  def find user
    @user = User.find(params[:user_id])
  end

  def review_params
    params.require(:review).permit(:comment)
  end
end
