class ListsController < ApplicationController
  # app/controllers/lists_controller.rb
  def index
  if params[:list_query].present?
    @lists = List.search_by_name(params[:list_query])
  else
    @lists = List.all
  end
  @bookmarks = Bookmark.where(list: @list)
  end

  def show
  @list = List.find(params[:id])

  if params[:movie_query].present?
    @movies = @list.movies.search_by_title_and_overview(params[:movie_query])
  else
    @movies = @list.movies
  end

  @bookmarks = Bookmark.where(list: @list)
  end

  def new
    @list = List.new
    # If you do want to create a bookmark for the list at the same time (not typical), you'll need:
    # @bookmark = Bookmark.new
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy

    redirect_to lists_path, notice: 'List was successfully deleted.'
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to @list, notice: 'List was successfully created.'
    else
      render :new
    end
  end

  def edit
    @list = List.find(params[:id])
    # If you do want to create a bookmark for the list at the same time (not typical), you'll need:
    # @bookmark = Bookmark.new
  end

  def update
    @list = List.find(params[:id])
    @list.update(list_params)
    if @list.save
      redirect_to @list, notice: 'List was successfully updated.'
    else
      render :edit
    end
  end

  private

  def list_params
    params.require(:list).permit(:name, :image)
  end
end
