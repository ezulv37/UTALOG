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
    if params[:user][:remove_image] == '1'
      @user.image.purge
    end

    if @user.update(profile_params)
      flash[:notice] =  I18n.t("flash.profile.update")
      redirect_to user_profile_path
    else
      render :edit, alert: "更新に失敗しました"
    end
  end

    # guest_log_in
    before_action :ensure_normal_user, only: :edit

    def ensure_normal_user
      if current_user.email == 'guest@guest.mail'
        redirect_to mypage_path(current_user), notice: t('flash.user.guest_restricted')
      end
    end

  private
  def profile_params
    params.require(:user).permit(:name, :image)
  end
end
