class PracticesController < ApplicationController
  before_action :authenticate_user!

  def new
    @practice = current_user.practices.new
  end

  def edit
    @practice = current_user.practices.find(params[:id])
  end

  def create
    @practice = current_user.practices.new(practice_params)

    if @practice.save
      flash[:notice] = I18n.t("flash.practice.create")
      redirect_to mypage_path
    else
      render :new
    end
  end

  def update
    @practice = current_user.practices.find(params[:id])
    if @practice.update(practice_params)
      flash[:notice] = I18n.t("flash.practice.update")
      redirect_to mypage_path
    else
      render :edit
    end
  end

  def destroy
    @practice = Practice.find(params[:id])
    @practice.destroy
    flash[:notice] = I18n.t("flash.practice.destroy")
    redirect_to mypage_path
  end

  private

  def practice_params
    params.require(:practice).permit(:title, :artist, :key, :comment, :score, :result_image1, :result_image2)
  end
end
