class TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy]

  # GET /tasks
  def index
    @tasks = Task.where(project: @user.projects)
    if params[:project_id]
      @tasks = @tasks.where(project_id: params[:project_id])
    end

    render json: @tasks.all
  end

  # GET /tasks/1
  def show
    render json: @task
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)
    @task.save
    render json: @task, status: :created, location: @task
  rescue ActionController::UnpermittedParameters => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  # PATCH/PUT /tasks/1
  def update
    @task.update(task_params)
    render json: @task
  rescue ActionController::UnpermittedParameters => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.where(id: params[:id], project: @user.projects).first!
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Task Not Found' }, status: :not_found
  end

  # Only allow a trusted parameter "white list" through.
  def task_params
    params.permit(:id, :project_id, :name, :description)
  end
end
