class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    song = Song.find(params[:song_id])
    current_user.favorite(song)
    redirect_to mypage_path(tab: 'repertoire')
  end

  def destroy
    song = Song.find(params[:song_id])
    current_user.unfavorite(song)
    redirect_to mypage_path(tab: 'repertoire')
  end
end
