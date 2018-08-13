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

    d = Device.create part_number: item[:name],
                      friendly_name: item[:description],
                      attribution: item[:attribution]


    if item[:addresses]
      item[:addresses].each do |addr|
        record = Address.find_by address: addr.to_i(16)
        unless record
          record = Address.create address: addr.to_i(16)
        end

        record.device << d
      end
    else
      puts '>>>>> NO ADDRESSES??'
      pp item
    end
  end

  File.open("i2c.json", 'w') { |f| f.write results.to_json.to_s }
end
