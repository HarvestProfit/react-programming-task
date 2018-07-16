class ApplicationController < ActionController::API
  before_action :authenticate

  def authenticate
    token = parse_jwt_from_header
    @user = User.where(id: token['user_id']).first!
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'You are not logged in.' }, status: :unauthenticated
  end

  private

  def parse_jwt_from_header
    auth_header = request.headers['Authorization']
    token = auth_header.split(' ').last
    decoded_token = JWT.decode(token, Rails.application.credentials.secret_key_base, true)
    decoded_token[0]
  end
end
