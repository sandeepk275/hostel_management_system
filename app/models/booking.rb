class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validate :start_date_before_end_date
  before_create :set_start_date

  scope :approved, -> { where(approved: true) }

  def start_date_before_end_date
    if start_date.present? && end_date.present? && start_date >= end_date
      errors.add(:start_date, "must be before the end date")
    end
  end

  def set_start_date
    self.start_date ||= Date.today
  end

  def update_room_status
    capacity = room.capacity
    booking_counts = room.bookings.approved.count
    if capacity <= booking_counts
      room.update(is_available: false)
    else
      room.update(is_available: true)
    end
  end
end
