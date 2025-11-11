class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 25 }

  has_one_attached :image

  has_many :songs, dependent: :destroy
  has_many :practices, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_songs, through: :favorites, source: :song

  # 引数に渡されたsongがブックマークされているか？
  def favorite?(song)
    favorite_songs.include?(song)
  end

  # song_idを入れてブックマークする
  def favorite(song)
    # current_userがブックマークしているsongの配列にsongを入れる
    favorite_songs << song
  end

  # 引数のsongのidをもつ、レコードを削除する
  def unfavorite(song)
    favorite_songs.destroy(song)
  end

  def self.guest
    find_or_create_by!(email: 'guest@guest.mail') do |user|
      user.name = 'ゲスト'
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
