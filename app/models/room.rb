class Room < ApplicationRecord
  belongs_to :hostel
  has_many :bookings

  validates :room_number, presence: true, uniqueness: { scope: :hostel_id, message: "Room number must be unique within a hostel" }
  validates :capacity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :price_per_bed, presence: true, numericality: { greater_than_or_equal_to: 0 }


  scope :available, -> { where(is_available: true) }
  scope :by_capacity, ->(capacity) { where('capacity >= ?', capacity) }
  scope :by_price_range, ->(min, max) { where(price_per_bed: min..max) }

end
