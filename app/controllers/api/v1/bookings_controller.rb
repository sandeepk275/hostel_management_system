class Api::V1::BookingsController < ApplicationController
  SERIALIZER = BookingSerializer
  before_action :authenticate_admin!, only: [:approve, :reject]

  # POST /rooms/:room_id/bookings
  def create
    room = Room.find_by(id: params[:room_id])
    return build_json_response(404, false, 'Room not found') unless room
    return build_json_response(400, false, 'Room not available for booking') unless room.is_available

    booking = room.bookings.new(booking_params)
    booking.user = current_user

    if booking.save
      build_json_response(200, true, 'Booking created successfully', booking: serialize(booking, serializer: SERIALIZER))
    else
      build_json_response(422, false, booking.errors.full_messages)
    end
  rescue StandardError => e
    build_json_response(500, false, "An unexpected error occurred: #{e.message}")
  end

  # GET /bookings
  def index
    if current_user.admin?
      bookings = Booking.all
      build_json_response(200, true, 'Fetched all bookings', bookings: serialize(bookings, serializer: SERIALIZER))
    else
      bookings = current_user.bookings
      build_json_response(200, true, 'Fetched personal bookings', bookings: serialize(bookings, serializer: SERIALIZER))
    end
  end

  # PUT /bookings/:id/approve
  def approve
    booking = Booking.find_by(id: params[:id])
    return build_json_response(404, false, 'Booking not found') unless booking
    return build_json_response(400, false, 'Room not available for booking') unless booking.room.is_available

    if booking.update(approved: true, rejected: false)
      booking.update_room_status
      build_json_response(200, true, 'Booking approved successfully', booking: serialize(booking, serializer: SERIALIZER))
    else
      build_json_response(422, false, booking.errors.full_messages)
    end
  end

  # PUT /bookings/:id/reject
  def reject
    booking = Booking.find_by(id: params[:id])
    return build_json_response(404, false, 'Booking not found') unless booking

    if booking.update(rejected: true, approved: false)
      build_json_response(200, true, 'Booking rejected successfully', booking: serialize(booking, serializer: SERIALIZER))
    else
      build_json_response(422, false, booking.errors.full_messages)
    end
  end

  # DELETE /bookings/:id
  def destroy
    booking = Booking.find_by(id: params[:id])
    return build_json_response(404, false, 'Booking not found') unless booking

    room = booking.room
    if booking.destroy
      booking.update_room_status
      build_json_response(200, true, 'Booking cancelled successfully')
    else
      build_json_response(422, false, booking.errors.full_messages)
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
