class Hostel < ApplicationRecord
  has_many :rooms, dependent: :destroy

  validates :name, :location, presence: true
  validates :name, uniqueness: true
  validates :email, format: { with: User::EMAIL_REGEX }
end
