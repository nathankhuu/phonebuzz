Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'call#index'
  post 'call/handler' => 'call#handler'
  post 'call/index' => 'call#handler'
end
