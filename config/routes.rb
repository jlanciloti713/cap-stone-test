Rails.application.routes.draw do
  devise_for :users
  
  devise_scope :user do
    authenticated :user do
      root 'users#show', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  get '/users' => 'users#index'
  put '/users/currentposition' => 'users#update_position'
  get 'users/update_show' => 'users#update_show'
  get '/users/:id' => 'users#show'

  get '/messages' => 'messages#index'
  get '/messages/:id' => 'messages#found_messages'
  post '/messages' => 'messages#create'
  put '/messages/:id' => 'messages#update'
  delete '/messages/:id' => 'messages#destroy'

  get '/kept_messages' => 'kept_messages#index'
  post '/kept_messages/:message_id/:user_id' => 'kept_messages#create'
  delete '/kept_messages/:id' => 'kept_messages#destroy'

end
