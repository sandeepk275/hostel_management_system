class Room < ApplicationRecord
  belongs_to :hostel

  validates :room_number, presence: true, uniqueness: true
  validates :capacity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :price_per_bed, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_many :bookings

  scope :available, -> { where(is_available: true) }
  scope :by_capacity, ->(capacity) { where('capacity >= ?', capacity) }
  scope :by_price_range, ->(min, max) { where(price_per_bed: min..max) }
end
