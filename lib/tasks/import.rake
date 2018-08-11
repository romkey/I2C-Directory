require 'i2c_import'

task :import => [ :environment ] do
  results = []

  page = I2CImport.download_page

  results = I2CImport.process_page page

  pp results
  results.each do |item|
    if Device.find_by part_number: item[:name]
      next
    end

    Device.create part_number: item[:name],
                  friendly_name: item[:description],
                  addresses: item[:addresses] || [],
                  reserved: false
  end

  File.open("i2c.json", 'w') { |f| f.write results.to_json.to_s }
end
