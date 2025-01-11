class ApplicationController < ActionController::API
	include ResponseConcern
	before_action :authenticate_user

  private

  def authenticate_user
    token = request.headers["Authorization"]&.gsub('Bearer ', '')
    if token.nil?
      return build_json_response(401, false, 'Authorization token is missing')
    end

    begin
      decoded = JWT.decode(token, Rails.application.secret_key_base).first
      @current_user = User.find(decoded['user_id'])
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      return build_json_response(401, false, 'Unauthorized')
    end
  end

  def authenticate_admin!
    unless current_user&.admin?
      return build_json_response(401, false, 'Unauthorized')
    end
  end
end
