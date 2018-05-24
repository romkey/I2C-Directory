json.extract! device, :id, :part_number, :friendly_name, :addresses, :datasheet, :adafruit, :sparkfun, :amazon, :created_at, :updated_at
json.url device_url(device, format: :json)
