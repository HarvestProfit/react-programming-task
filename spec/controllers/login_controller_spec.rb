require 'rails_helper'

RSpec.describe LoginController, type: :controller do
  it 'should login a user just fine' do
    user = create(:user)
    post :create, params: { email: user.email, password: user.password }
    expect(response).to have_http_status(:success)
  end

  it 'should not login a user just fine with a bad password' do
    user = create(:user)
    post :create, params: { email: user.email, password: 'not-the-password-yo' }
    expect(response).to have_http_status(422)
  end

  it 'should not login a user just fine with a bad email' do
    user = create(:user)
    post :create, params: { email: 'bob-dude', password: 'not-the-password-yo' }
    expect(response).to have_http_status(422)
  end
end
