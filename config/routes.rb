Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :urls, only: [:index, :create]

  root to: "urls#index"
end
