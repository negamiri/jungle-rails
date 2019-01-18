class ReviewsController < ApplicationController

  before_action :verify_logged_in

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.product_id = params[:product_id]
    @review.user = current_user

    if @review.save!
      redirect_to product_path(@review.product_id), notice: 'Thanks for your review!'
    else
      redirect_to product_path(@review.product_id)
    end
  end

  private
  def review_params
    params.require(:review).permit(
      :description, 
      :rating
    )
  end

end
