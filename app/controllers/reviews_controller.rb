class ReviewsController < ApplicationController
  before_action :find_user, except: [:destroy]

  def new
    @review = Review.new
  end

  def edit; end

  def create
    @review = Review.new(review)
    @review.user = @user
    if @review.save
    redirect_to user_path(@user)
  else
    render :new
  end
  end

  def destroy
  @review = Review.find(params[:id])
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
