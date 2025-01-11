# app/serializers/hostel_serializer.rb
class HostelSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :location, :description, :contact_number, :email, :created_at, :updated_at
end
