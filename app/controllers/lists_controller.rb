class ListsController < ApplicationController
  # app/controllers/lists_controller.rb
  def index
    @lists = List.includes(bookmarks: :movie).all
  end

  def show
    @list = List.find(params[:id])
    @movies = @list.movies  # Fetch movies associated with the list.
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list)
    else
      render :new
    end
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
