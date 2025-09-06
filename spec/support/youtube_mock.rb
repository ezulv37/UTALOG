require 'ostruct'

RSpec.configure do |config|
  config.before(:each) do
    # YouTube API のモック
    youtube_double = double('youtube_service')

    # コントローラで参照している youtube_service をモックに差し替え
    allow(Rails.application.config).to receive(:youtube_service).and_return(youtube_double)

    # デフォルト検索（ページ読み込み時）
    allow(youtube_double).to receive(:list_searches).with(
      'snippet',
      hash_including(q: '歌唱 テクニック')
    ).and_return(
      OpenStruct.new(
        items: [
          OpenStruct.new(
            id: OpenStruct.new(kind: 'youtube#video', video_id: 'default123'),
            snippet: OpenStruct.new(title: 'デフォルト動画',thumbnails: OpenStruct.new(default: OpenStruct.new(url: 'https://example.com/default.jpg')
              )
            )
          )
        ]
      )
    )

    # 任意のキーワード検索（例: アーティスト名）
    allow(youtube_double).to receive(:list_searches).with(
      'snippet',
      hash_including(q: 'アーティスト1')
    ).and_return(
      OpenStruct.new(
        items: [
          OpenStruct.new(
            id: OpenStruct.new(kind: 'youtube#video', video_id: 'search123'),
            snippet: OpenStruct.new(title: '検索結果動画',thumbnails: OpenStruct.new(default: OpenStruct.new(url: 'https://example.com/search.jpg')
              )
            )
          )
        ]
      )
    )
  end
end
