@devices.each do |item|
  xml.url do
    xml.loc device_url(item)
  end
end
