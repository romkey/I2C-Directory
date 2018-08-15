base_url = "http://#{request.host_with_port}/"

@pages.each do |page|
  xml.url do
    xml.loc base_url+page
  end

end
