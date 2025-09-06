class HomeController < ApplicationController
  def index
    @practice_logs = Practice.includes(user: { image_attachment: :blob }).order(created_at: :desc)

    youtube = Rails.application.config.youtube_service
    if params[:query].present?
      @videos = search_youtube_videos(params[:query], youtube)
    else
      @videos = search_youtube_videos("歌唱 テクニック", youtube)
    end
  end

  private

  def search_youtube_videos(query, youtube)
    # queryごとにユニークなキャッシュキーを作成
    cache_key = "youtube_search_#{Digest::MD5.hexdigest(query)}"

    # キャッシュがあればそれを返す、なければAPI呼び出し
    Rails.cache.fetch(cache_key, expires_in: 12.hours) do
      response = youtube.list_searches(
        'snippet',
        q: query,
        type: 'video',
        max_results: 1,
        video_embeddable: 'true'
      )

      response.items.select { |item| item.id.kind == 'youtube#video' }.map do |item|
        {
          title: item.snippet.title,
          video_id: item.id.video_id,
          thumbnail_url: item.snippet.thumbnails.default.url
        }
      end
    end
  end
end
