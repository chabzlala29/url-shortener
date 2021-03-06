Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :urls, only: [:new, :create]

  get "/data/:short_url", to: "urls#show"
  get ":short_url", to: "urls#index"

  root to: "urls#new"
end
