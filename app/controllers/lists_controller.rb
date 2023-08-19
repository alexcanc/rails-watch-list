class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  def index
    if params[:list_query].present?
      @lists = List.search_by_name(params[:list_query])
    else
      @lists = List.all
    end
    @bookmarks = Bookmark.where(list: @list)
  end

  def show
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

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to lists_path, notice: 'List was successfully created.'
    else
      render :new
    end
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    # You've already set @list using before_action
    if @list.update(list_params)  # .update will save the model if validations pass
      redirect_to lists_path, notice: 'List was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    # You've already set @list using before_action
    @list.destroy
    redirect_to lists_path, notice: 'List was successfully deleted.'
  end

  private

  def list_params
    params.require(:list).permit(:name, :image)
  end

  def set_list
    @list = List.find(params[:id])
  end
end
