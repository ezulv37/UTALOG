class Song < ApplicationRecord
  belongs_to :user

  validates :title, :artist, presence: true
  validates :key, numericality: { only_integer: true }, allow_nil: true
  validates :memo, length: { maximum: 200 }, allow_blank: true
end
