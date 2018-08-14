Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations"}
  resources :addresses, param: :slug
  resources :devices, param: :slug
  get '/admin/clear_database', to: 'admin#clear_database'
end
