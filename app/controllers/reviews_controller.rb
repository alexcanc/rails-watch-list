class ReviewsController < ApplicationController

  def new
    @review = Review.new
  end

  def create
    @list = List.find(params[:list_id])
    @review = @list.reviews.new(review_params)

    if @review.save
      redirect_to list_path(@list)
    else
      flash[:alert] = "Something went wrong."
      render :new
    end
  end

  private

def review_params
  params.require(:review).permit(:content, :rating)
end

end
