class MypageController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @songs = current_user.songs
  end
end
