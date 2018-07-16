class UsersController < ApplicationController
  skip_before_action :authenticate, only: [:create]

  # GET /users
  def index
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)
    @user.save
    render json: @user, status: :created, location: @user
  rescue ActionController::UnpermittedParameters => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  # PATCH/PUT /users/1
  def update
    @user.update(user_params)
    render json: @user
  rescue ActionController::UnpermittedParameters => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.permit(:id, :email, :password, :password_confirmation)
  end
end
