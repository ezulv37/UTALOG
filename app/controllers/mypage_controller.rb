class MypageController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @songs = current_user.songs.order(created_at: :desc)
    @practices = current_user.practices.order(created_at: :desc)
    @score_average = current_user.practices.average(:score).to_f.round(1)
  end
end
