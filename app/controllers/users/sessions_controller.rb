# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  # guest_log_in
  def guest_log_in
    user = User.guest
    sign_in user
    redirect_to mypage_path, notice: 'ゲストとしてログインしました'
  end

  protected

  def after_sign_in_path_for(resource)
    mypage_path
  end
end
