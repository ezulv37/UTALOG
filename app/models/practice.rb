class Practice < ApplicationRecord
  belongs_to :user

  has_one_attached :result_image1
  has_one_attached :result_image2

  validates :title, :artist, presence: true
  validates :key, numericality: { only_integer: true }, allow_nil: true
  validates :score, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :comment, length: { maximum: 200 }, allow_blank: true
end
