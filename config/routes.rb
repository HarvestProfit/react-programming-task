Rails.application.routes.draw do
  root 'pages#home'
  scope :api do
    post 'login', to: 'login#create'
    resources :tasks
    resources :projects
    delete :users, to: 'users#destroy'
    get :users, to: 'users#index'
    post :users, to: 'users#create'
    put :users, to: 'users#update'
  end
end
