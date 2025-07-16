class Song < ApplicationRecord
  belongs_to :user

  validates :title, :artist, presence: true
end
