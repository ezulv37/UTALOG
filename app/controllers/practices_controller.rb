class PracticesController < ApplicationController
  before_action :authenticate_user!

  def new
    @practice = current_user.practices.new
  end

  def create
    @practice = current_user.practices.new(practice_params)

    if @practice.save
      flash[:notice] = "練習ログを新規登録しました"
      redirect_to mypage_path
    else
      render :new
    end
  end

  def edit
    @practice = current_user.practices.find(params[:id])
  end

  def update
    @practice = current_user.practices.find(params[:id])
    if @practice.update(practice_params)
      flash[:notice] = "練習ログを更新しました"
      redirect_to mypage_path
    else
      render :edit
    end
  end

  def destroy
    @practice = Practice.find(params[:id])
    @practice.destroy
    flash[:notice] = "練習ログを削除しました"
    redirect_to mypage_path
  end

  private

  def practice_params
    params.require(:practice).permit(:title, :artist, :key, :comment, :score, :result_image1, :result_image2)
  end
end
