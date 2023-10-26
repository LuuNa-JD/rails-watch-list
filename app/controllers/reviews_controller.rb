class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to list_path(@review.list_id)
    else
      render :new
    end
  end

  def new
    @list = List.find(params[:list_id])
    @review = Review.new
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating, :list_id)
  end
end
