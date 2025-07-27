class HomeController < ApplicationController
  def index
    @practice_logs = Practice.includes(user: { image_attachment: :blob }).order(created_at: :desc)
  end
end
