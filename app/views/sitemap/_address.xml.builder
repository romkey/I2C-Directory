@addresses.each do |item|
  xml.url do
    xml.loc address_url(item)
  end
end
