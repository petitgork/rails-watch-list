class BookmarksController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

  def create
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new(bookmarks_params)
    @bookmark.list_id = params[:list_id]
    if @bookmark.save
      redirect_to list_path(params[:list_id])
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    bookmark = Bookmark.find(params[:id])
    list = bookmark.list
    bookmark.delete
    redirect_to list_path(list), status: :see_other
  end

  private

  def bookmarks_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end

end
