Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations"}

  # device suggestions
  get '/devices/suggest_new' => 'devices#suggest_new'

  resources :addresses, param: :slug
  resources :devices, param: :slug

  get '/admin/clear_database', to: 'admin#clear_database'
  get '/admin/', to: 'admin#index'

  # page routing
  get '/', to: 'high_voltage/pages#show', id: 'root'
  get 'about', to: 'high_voltage/pages#show', id: 'about'

  # XML sitemap
  get "/sitemap.xml" => "sitemap#index", :format => "xml", :as => :sitemap

  # RSS feed
  get '/feed' => 'devices#index', format: "rss"
end
