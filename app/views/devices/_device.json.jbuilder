json.extract! device, :id, :part_number, :friendly_name, :datasheet, :adafruit, :sparkfun, :amazon,
              :created_at, :updated_at
json.addresses device.address.map(&:to_s)
json.url device_url(device, format: :json)
