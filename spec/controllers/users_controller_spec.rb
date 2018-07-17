require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:user) { create(:user) }
  let(:valid_headers) {
    { 'Authorization' => JWT.encode({ user_id: user.id }, Rails.application.credentials.secret_key_base) }
  }

  describe "GET #index" do
    it "returns a success response" do
      request.headers.merge! valid_headers
      get :index
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:valid_attributes) {
        { email: 'jaryd@123test.com', password: 'password123', password_confirmation: 'password123' }
      }

      it "creates a new User" do
        expect {
          post :create, params: valid_attributes
        }.to change(User, :count).by(1)
      end

      it "renders a JSON response with the new user" do
        post :create, params: valid_attributes
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      let(:invalid_attributes) {
        { name: 'bob' }
      }

      it "renders a JSON response with errors for the new user" do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "updates the requested user" do
        request.headers.merge! valid_headers
        put :update, params: { id: user.id, email: '123test@email.com' }
        user.reload
        expect(user.email).to eq('123test@email.com')
      end

      it "renders a JSON response with the user" do
        request.headers.merge! valid_headers
        put :update, params: { id: user.id, email: '123test@email.com' }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the user" do
        request.headers.merge! valid_headers
        put :update, params: { id: user.id, name: '123test@email.com' }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      request.headers.merge! valid_headers
      expect {
        delete :destroy, params: { id: user.to_param }
      }.to change(User, :count).by(-1)
    end
  end

end
