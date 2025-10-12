class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 25 }

  has_one_attached :image

  has_many :songs, dependent: :destroy
  has_many :practices, dependent: :destroy

  def self.guest
    find_or_create_by!(email: 'guest@guest.mail') do |user|
      user.name = 'ゲスト'
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
