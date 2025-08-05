class SongsController < ApplicationController
  before_action :authenticate_user!

  def new
    @song = current_user.songs.new
  end

  def edit
    @song = current_user.songs.find(params[:id])
  end

  def create
    @song = current_user.songs.new(song_params)
    if @song.save
      flash[:notice] = I18n.t("flash.song.create")
      redirect_to mypage_path(tab: 'repertoire')
    else
      render :new
    end
  end

  def update
    @song = current_user.songs.find(params[:id])
    if @song.update(song_params)
      flash[:notice] = I18n.t("flash.song.update")
      redirect_to mypage_path(tab: 'repertoire')
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = I18n.t("flash.song.destroy")
    redirect_to mypage_path(tab: 'repertoire')
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist, :genre, :key, :memo)
  end
end
