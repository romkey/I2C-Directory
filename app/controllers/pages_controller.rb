class PagesController < ApplicationController
  PAGES = %w[root about].freeze

  def show
    page = params[:id].to_s
    raise ActionController::RoutingError, "Page not found: #{page}" unless PAGES.include?(page)

    render template: "pages/#{page}"
  end
end
