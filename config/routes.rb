Rails.application.routes.draw do
  devise_for :users
  get '/' => 'users#index'
  get '/users' => 'users#index'
  put '/users/currentposition' => 'users#update_position'
  get '/users/:id' => 'users#show'
  get '/messages' => 'messages#index'
  post '/messages' => 'messages#create'
  delete '/messages/:id' => 'messages#destroy'
end
