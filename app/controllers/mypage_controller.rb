class MypageController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @songs = current_user.songs.order(created_at: :desc)
    @practices = current_user.practices.order(created_at: :desc)
    @score_average = Float(current_user.practices.average(:score) || 0).round(1)

    # 練習ログの検索
    if params[:practice_q].present?
      keyword = "%#{params[:practice_q]}%"
      @practices = @practices.where("title LIKE :kw OR artist LIKE :kw", kw: keyword)
    end

    # 楽曲レパートリーの検索
    if params[:song_q].present?
      keyword = "%#{params[:song_q]}%"
      @songs = @songs.where("title LIKE :kw OR artist LIKE :kw", kw: keyword)
    end

    if params[:genres].present?
      @songs = @songs.where(genre: params[:genres])
    end

    # お気に入りの検索
    if params[:favorite] == "1"
      favorite_song_ids = current_user.favorites.pluck(:song_id)
      @songs = @songs.where(id: favorite_song_ids)
    end
  end
end
