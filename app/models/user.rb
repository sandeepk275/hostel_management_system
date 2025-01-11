class User < ApplicationRecord
  EMAIL_REGEX = /\A[a-z0-9\+\-_\.\']+@[a-z\d\-.]+\.[a-z]+\z/i

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { resident: 0, admin: 1 }, _default: :resident

  validates :email, presence: true, format: { with: EMAIL_REGEX, message: 'format is not correct' }
  validates :role, :name, presence: true

  has_many :bookings

  def generate_jwt
    payload = { user_id: self.id, exp: 24.hours.from_now.to_i }
    JWT.encode(payload, Rails.application.secret_key_base)
  end
end
