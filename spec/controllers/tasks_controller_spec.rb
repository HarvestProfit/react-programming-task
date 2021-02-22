require 'rails_helper'

RSpec.describe TasksController, type: :controller do

  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let(:valid_headers) {
    { 'Authorization' => JWT.encode({ user_id: user.id }, Rails.application.credentials.secret_key_base) }
  }

  describe "GET #index" do
    it "returns a success response" do
      task = create(:task, project: project)
      request.headers.merge! valid_headers
      get :index, params: {}
      expect(response).to have_http_status(:success)
    end

    it "returns a success response if filtered by project" do
      task = create(:task, project: project)
      request.headers.merge! valid_headers
      get :index, params: { project_id: project.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      task = create(:task, project: project)
      request.headers.merge! valid_headers
      get :show, params: { id: task.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:valid_attributes) {
        { name: 'something', description: 'a long description', project_id: project.id }
      }

      it "creates a new Task" do
        request.headers.merge! valid_headers
        expect {
          post :create, params: valid_attributes
        }.to change(Task, :count).by(1)
      end

      it "renders a JSON response with the new task" do
        request.headers.merge! valid_headers
        post :create, params: valid_attributes
        expect(response).to have_http_status(:created)
        expect(response.content_type).to include('application/json')
        expect(response.location).to eq(task_url(Task.last))
      end
    end

    context "with invalid params" do
      let(:invalid_attributes) {
        { bogus: 'value' }
      }

      it "renders a JSON response with errors for the new task" do
        request.headers.merge! valid_headers
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "updates the requested task" do
        task = create(:task, project: project)
        request.headers.merge! valid_headers
        put :update, params: { id: task.id, name: 'a new name' }
        task.reload
        expect(task.name).to eq('a new name')
      end

      it "renders a JSON response with the task" do
        task = create(:task, project: project)
        request.headers.merge! valid_headers
        put :update, params: { id: task.id, name: 'a new name' }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to include('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the task" do
        task = create(:task, project: project)
        request.headers.merge! valid_headers
        put :update, params: { id: task.id, something: 'ridiculous' }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested task" do
      task = create(:task, project: project)
      request.headers.merge! valid_headers
      expect {
        delete :destroy, params: { id: task.id }
      }.to change(Task, :count).by(-1)
    end
  end

end
