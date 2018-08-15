@addresses.each do |item|
  xml.url do
    xml.loc address_path(item)
  end
end
