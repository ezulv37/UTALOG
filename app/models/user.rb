class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 25 }

  has_one_attached :image

  has_many :songs, dependent: :destroy
  has_many :practices, dependent: :destroy
end
