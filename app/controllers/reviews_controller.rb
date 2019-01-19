class ReviewsController < ApplicationController

  before_filter :authorize

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.product_id = params[:product_id]
    @review.user = current_user

    if @review.save!
      flash[:notice] = 'Thanks for your review!'
    else
      flash[:notice] = `Woops something went wrong with your review. Please ensure you're logged in`
    end

    redirect_to product_path(@review.product_id)
  end

  def destroy
    @review = Review.find(params[:id])
    product = @review.product
    @review.destroy!
    redirect_to product_path(product)
  end

  private
  def review_params
    params.require(:review).permit(
      :description, 
      :rating
    )
  end

end
