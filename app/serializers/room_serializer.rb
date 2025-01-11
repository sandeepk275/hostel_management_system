class RoomSerializer
  include JSONAPI::Serializer

  attributes :id, :room_number, :capacity, :price_per_bed, :is_available, :hostel_id

  attribute :hostel do |object|
    object.hostel
  end
end
