class SongsController < ApplicationController
  def index
  end

  def new
    @song = current_user.songs.new
  end

  def create
    @song = current_user.songs.new(params.require(:song).permit(:title, :artist, :genre, :key, :memo))
    if @song.save
      flash[:notice] = "レパートリー楽曲を新規登録しました"
      redirect_to mypage_path
    else
      render "new"
    end
  end

  def show
  end

  def edit
    @song = current_user.songs.find(params[:id])
  end

  def update
    @song = current_user.songs.find(params[:id])
    if @song.update(params.require(:song).permit(:title, :artist, :genre, :key, :memo))
      flash[:notice] = "レパートリー楽曲を更新しました"
      redirect_to mypage_path
    else
      render "edit"
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "レパートリー楽曲を削除しました"
    redirect_to mypage_path
  end
end
