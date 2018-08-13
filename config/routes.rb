Rails.application.routes.draw do
  resources :addresses, param: :slug
  resources :devices, param: :slug
  get '/admin/clear_database', to: 'admin#clear_database'
end
