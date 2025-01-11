class Api::V1::RoomsController < ApplicationController
  before_action :authenticate_admin!, except: [:index, :search]
  SERIALIZER = RoomSerializer

  def index
    hostel = Hostel.find_by(id: params[:hostel_id])
    return build_json_response(404, false, 'Hostel not found') unless hostel
    rooms = hostel.rooms
    build_json_response(200, true, 'Fetched room records successfully', rooms: serialize(rooms, serializer: SERIALIZER))
  end

  def create
    hostel = Hostel.find_by(id: params[:hostel_id])
    return build_json_response(404, false, 'Hostel not found') unless hostel
    
    room = hostel.rooms.new(room_params)
    if room.save
      build_json_response(200, true, 'Room created successfully', room: serialize(room, serializer: SERIALIZER))
    else
      build_json_response(422, false, room.errors.full_messages)
    end
  end

  def update
    room = Room.find_by(id: params[:id])
    return build_json_response(404, false, 'Room not found') unless room
    
    if room.update(room_params)
      build_json_response(200, true, 'Room updated successfully', room: serialize(room, serializer: SERIALIZER))
    else
      build_json_response(422, false, room.errors.full_messages)
    end
  end

  def destroy
    room = Room.find_by(id: params[:id])
    return build_json_response(404, false, 'Room not found') unless room
    
    if room.destroy
      build_json_response(200, true, 'Room deleted successfully')
    else
      build_json_response(422, false, room.errors.full_messages)
    end
  end

  def search
    rooms = Room.all

    rooms = rooms.available if params[:is_available].present? && params[:is_available].to_s.downcase == 'true'

    rooms = rooms.by_capacity(params[:capacity].to_i) if params[:capacity].present?

    if params[:min_price].present? && params[:max_price].present?
      rooms = rooms.by_price_range(params[:min_price].to_f, params[:max_price].to_f)
    end

    build_json_response(200, true, 'Filtered rooms fetched successfully', rooms: serialize(rooms, serializer: SERIALIZER))
  end

  private

  def room_params
    params.require(:room).permit(:room_number, :capacity, :price_per_bed, :is_available)
  end
end
