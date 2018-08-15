@devices.each do |item|
  xml.url do
    xml.loc device_path(item)
  end
end
