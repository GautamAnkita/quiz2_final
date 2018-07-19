Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :edit, :update]

  resources :ideas do
    resources :reviews, only: [:create, :destroy, :show]
  end

  get "/", to: "ideas#index" ,as: :home
end
