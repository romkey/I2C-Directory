Rails.application.routes.draw do
  resources :addresses
  resources :devices
  get '/admin/clear_database', to: 'admin#clear_database'
end
