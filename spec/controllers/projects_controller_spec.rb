require 'rails_helper'
require 'projects_controller'

RSpec.describe ProjectsController, type: :controller do

  let(:user) { create(:user) }
  let(:valid_headers) {
    { 'Authorization' => JWT.encode({ user_id: user.id }, Rails.application.credentials.secret_key_base) }
  }

  describe "GET #index" do
    it "returns a success response" do
      project = create(:project, user: user)
      request.headers.merge! valid_headers
      get :index, params: {}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      project = create(:project, user: user)
      request.headers.merge! valid_headers
      get :show, params: {id: project.id}
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do

    let(:valid_attributes) {
      { name: 'Project #1', description: 'Some description' }
    }

    let(:invalid_attributes) {
      { something: 'weird' }
    }

    context "with valid params" do
      it "creates a new Project" do
        request.headers.merge! valid_headers
        expect { post :create, params: valid_attributes }.to change(Project, :count).by(1)
      end

      it "renders a JSON response with the new project" do
        request.headers.merge! valid_headers
        post :create, params: valid_attributes
        expect(response).to have_http_status(:created)
        expect(response.content_type).to include('application/json')
        expect(response.location).to eq(project_url(Project.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new project" do
        request.headers.merge! valid_headers
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          name: 'something'
        }
      }

      it "updates the requested project" do
        project = create(:project, user: user)
        request.headers.merge! valid_headers
        put :update, params: {id: project.id, name: 'Project 100' }
        project.reload
        expect(project.name).to eq('Project 100')
      end

      it "renders a JSON response with the project" do
        project = create(:project, user: user)
        request.headers.merge! valid_headers
        put :update, params: {id: project.id, name: 'Project 100' }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to include('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the project" do
        project = create(:project, user: user)
        request.headers.merge! valid_headers
        put :update, params: {id: project.id, name: 'Valid name', something: 'Project 100' }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested project" do
      project = create(:project, user: user)
      request.headers.merge! valid_headers
      expect {
        delete :destroy, params: {id: project.id}
      }.to change(Project, :count).by(-1)
    end
  end

end
