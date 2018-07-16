class LoginController < ApplicationController
  skip_before_action :authenticate, only: [:create]

  def create
    user = User.where(email: params[:email]).first!
    if user.authenticate(params[:password])
      payload = { user_id: user.id }
      render json: { token: JWT.encode(payload, Rails.application.credentials.secret_key_base) }
    else
      render json: { error: 'The password you have provided is incorrect' }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'The email you have entered does not match any current accounts' }, status: :unprocessable_entity
  end
end
