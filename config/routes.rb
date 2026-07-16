Rails.application.routes.draw do
  # Health check endpoint for load balancers and uptime monitors.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :resources

  devise_for :users, controllers: { registrations: "registrations" }

  # device suggestions
  get "/devices/suggest_new" => "devices#suggest_new"

  resources :addresses, param: :slug
  resources :devices, param: :slug

  get "/devices/:slug/clear_suggestions", to: "devices#clear_suggestions"
  get "/devices/:slug/driver/:driver_id", to: "devices#driver"

  get "/admin/clear_database", to: "admin#clear_database"
  post "/admin/import", to: "admin#import"
  get "/admin", to: "admin#index"

  # contact form
  get "/contact", to: "contacts#new"
  post "/contact", to: "contacts#create"

  # XML sitemap
  get "/sitemap.xml" => "sitemap#index", :format => "xml", :as => :sitemap

  # RSS feed
  get "/feed" => "devices#index", format: "rss"

  # static pages
  get "/about", to: "pages#show", defaults: { id: "about" }
  root to: "pages#show", defaults: { id: "root" }
end
