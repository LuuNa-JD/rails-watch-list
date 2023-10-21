class BookmarksController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

  # Enregistrer un nouveau signet dans une liste existante
  def create
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list

  if @bookmark.save
    redirect_to list_path(@list), notice: 'Le signet a été ajouté avec succès.'
  else
    flash[:alert] = 'Erreur lors de la création du signet.'
    render :new
    end
  end

  # Supprimer un signet d'une liste
  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to @bookmark.list, notice: 'Le signet a été supprimé avec succès.'
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
