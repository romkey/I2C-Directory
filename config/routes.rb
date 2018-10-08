Rails.application.routes.draw do
  resources :resources
  devise_for :users, controllers: { registrations: "registrations"}

  # device suggestions
  get '/devices/suggest_new' => 'devices#suggest_new'

  resources :addresses, param: :slug
  resources :devices, param: :slug

  get '/devices/:slug/clear_suggestions', to: 'devices#clear_suggestions'

  get '/admin/clear_database', to: 'admin#clear_database'
  post '/admin/import', to: 'admin#import'
  get '/admin/', to: 'admin#index'

  # contact form
  get '/contact', to: 'contact_us/contacts#new'

  # page routing
  get '/', to: 'high_voltage/pages#show', id: 'root'
  get 'about', to: 'high_voltage/pages#show', id: 'about'

  # XML sitemap
  get "/sitemap.xml" => "sitemap#index", :format => "xml", :as => :sitemap

  # RSS feed
  get '/feed' => 'devices#index', format: "rss"
end
