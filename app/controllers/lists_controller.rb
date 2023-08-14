class ListsController < ApplicationController
  # app/controllers/lists_controller.rb
  def index
    if params[:list_query].present?
      @lists = List.search_by_name(params[:list_query])
    else
      @lists = List.all
    end
  end

  def show
    @list = List.find(params[:id])

    if params[:movie_query].present?
      @movies = @list.movies.search_by_title_and_overview(params[:movie_query])
    else
      @movies = @list.movies
    end
  end

  def new
    @list = List.new
    # If you do want to create a bookmark for the list at the same time (not typical), you'll need:
    # @bookmark = Bookmark.new
  end


  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to lists_path
    else
      render :new
    end
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
