# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # GET /resource/sign_up
  def new
    super
  end

  # GET /resource/edit
  def edit
    super
  end

  # POST /resource
  def create
    super
  end

  # PUT /resource
  def update
    super do |resource|
      if params[:user][:password].blank? || params[:user][:password_confirmation].blank?
        return render :edit
      end

      if resource.errors.empty? && params[:user][:password].present?
        sign_out(resource)
        flash[:notice] = I18n.t("devise.passwords.updated")
        redirect_to root_path and return
      end
    end
  end

  # DELETE /resource
  def destroy
    super
  end

  # guest_log_in
  before_action :ensure_normal_user, only: :edit

  def ensure_normal_user
    if resource.email == 'guest@guest.mail'
      redirect_to mypage_path(@user.id), notice: t('flash.user.guest_restricted')
    end
  end

  protected

  def after_sign_up_path_for(resource)
    user_profile_path
  end
end
