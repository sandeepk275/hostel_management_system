class Api::V1::HostelsController < ApplicationController
  before_action :authenticate_admin!, except: [:index]
  SERIALIZER = HostelSerializer

  def index
    hostels = Hostel.all
    build_json_response(200, true, 'Fetch hostel records successfully',hostels: serialize(hostels, serializer: SERIALIZER))
  end

  def create
    hostel = Hostel.new(hostel_params)
    if hostel.save
      build_json_response(200, true, 'Hostel created successfully',hostels: serialize(hostel, serializer: SERIALIZER))
    else
      build_json_response(422, false, hostel.errors.full_messages)
    end
  end

  def update
    hostel = Hostel.find_by(id: params[:id])
    return build_json_response(404, true, 'Record not found') unless hostel
    if hostel.update(hostel_params)
      build_json_response(200, true, 'Hostel updated successfully', room: serialize(hostel, serializer: SERIALIZER))
    else
      build_json_response(422, false, hostel.errors.full_messages)
    end
  end

  def destroy
    hostel = Hostel.find_by(id: params[:id])
    return build_json_response(404, true, 'Record not found') unless hostel

    if hostel.destroy
      build_json_response(200, true, 'Hostel deleted successfully')
    else
      build_json_response(422, false, hostel.errors.full_messages)
    end
  end

  private

  def hostel_params
    params.require(:hostel).permit(:name, :location, :description, :contact_number, :email)
  end
end
