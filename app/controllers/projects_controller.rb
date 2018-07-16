class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy]

  # GET /projects
  def index
    @projects = Project.where(user: @user).all

    render json: @projects
  end

  # GET /projects/1
  def show
    render json: @project
  end

  # POST /projects
  def create
    @project = Project.new(project_params)
    @project.user = @user
    @project.save
    render json: @project, status: :created, location: @project
  rescue ActionController::UnpermittedParameters => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  # PATCH/PUT /projects/1
  def update
    @project.update(project_params)
    render json: @project
  rescue ActionController::UnpermittedParameters => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.where(id: params[:id], user: @user).first!
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Project not found' }, status: :not_found
  end

  # Only allow a trusted parameter "white list" through.
  def project_params
    params.permit(:id, :name, :description, :image_url)
  end
end
