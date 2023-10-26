class HomeController < ApplicationController
  before_action :set_list, only: [:show]

  def index
    @lists = List.all
    @review = Review.new  # Crée une nouvelle critique non associée
  end

  def create_review
    @review = Review.new(review_params)

    if @review.save
      redirect_to root_path
    else
      @lists = List.all
      render :index
    end
  end

  private

  def set_list
    @list = List.find(params[:id]) if params[:id].present?
  end

  def review_params
    params.require(:review).permit(:content, :rating, :list_id)
  end
end
