@resources.each do |item|
  xml.url do
    xml.loc resource_url(item)
  end
end
