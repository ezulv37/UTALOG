class Song < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy

  validates :title, :artist, :genre, presence: true
  validates :key, numericality: { only_integer: true }, allow_nil: true
  validates :memo, length: { maximum: 200 }, allow_blank: true
end
