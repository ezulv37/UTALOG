class SongsController < ApplicationController
  before_action :authenticate_user!

  def new
    @song = current_user.songs.new
  end

  def create
    @song = current_user.songs.new(song_params)
    if @song.save
      flash[:notice] = "レパートリー楽曲を新規登録しました"
      redirect_to mypage_path
    else
      render :new
    end
  end

  def edit
    @song = current_user.songs.find(params[:id])
  end

  def update
    @song = current_user.songs.find(params[:id])
    if @song.update(song_params)
      flash[:notice] = "レパートリー楽曲を更新しました"
      redirect_to mypage_path
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "レパートリー楽曲を削除しました"
    redirect_to mypage_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist, :genre, :key, :memo)
  end
end
