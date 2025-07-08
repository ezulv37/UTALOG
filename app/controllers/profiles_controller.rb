class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    # チェックボックスがONなら画像を削除
    if params[:remove_image] == "1"
      @user.image.purge
    end

    if @user.update(profile_params)
      flash[:notice] =  "プロフィールを更新しました"
      redirect_to user_profile_path
    else
      render :edit, alert: "更新に失敗しました"
    end
  end

  private
  def profile_params
    params.require(:user).permit(:name, :image)
  end
end
