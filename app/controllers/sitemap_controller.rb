class SitemapController < ApplicationController
  def index
    @pages = ['', 'about' ]

    @devices = Device.all
    @addresses = Address.all
    @resources = Resource.all

    respond_to do |format|
      format.xml
    end
  end
end
