class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 25 }

  has_one_attached :image

  has_many :songs, dependent: :destroy
  has_many :practices, dependent: :destroy
end
