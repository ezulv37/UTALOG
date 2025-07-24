class MypageController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @songs = current_user.songs
    @practices = current_user.practices
    @score_average = current_user.practices.average(:score).to_f.round(1)
  end
end
