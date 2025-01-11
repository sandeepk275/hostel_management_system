class Api::V1::AuthController < ApplicationController
  skip_before_action :authenticate_user
  SERIALIZER = UserSerializer
  def signup
    user = User.new(user_params)
    if user.save
      build_json_response(200, true, 'User created successfully',token: user.generate_jwt, user: serialize(user, serializer: SERIALIZER))
    else
      build_json_response(422, false, user.errors.full_messages)
    end
  rescue StandardError => e
    build_json_response(500, false, "Something went wrong: #{e.message}")
  end

  def login
    user = User.find_by_email(params[:email])
    if user&.valid_password?(params[:password])
      build_json_response(200, true, 'User login successfully', token: user.generate_jwt, user: serialize(user, serializer: SERIALIZER))
    else
      build_json_response(401, true, 'Invalid credentials')
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end
end
