Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :workout_plans do
    resources :rounds do
      resources :exercises
      resources :rests
    end
  end

  resources :users

  get 'welcome/index'
  root "welcome#index"

  get '/login' => 'session#new'
  post '/login' => 'session#create'
  get '/logout' => 'session#destroy'

  get '/signup' => 'users#new'
end
