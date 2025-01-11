class BookingSerializer
  include JSONAPI::Serializer

  attributes :id, :start_date, :end_date, :approved, :rejected

  attribute :user do |object|
    object.user
  end
  attribute :room do |object|
    object.room
  end
end
