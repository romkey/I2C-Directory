require 'I2CappSearch/search_for_drivers'

class SuggestDriversJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Device.needs_drivers.where(scanned_drivers: false).limit(10).each do |device|
      pages = I2CappSearch.search_for_drivers device.part_number

      if pages
        pages.each do |page|
          device.datasheet_suggestions << DatasheetSuggestion.create(title: page[:title], link: page[:link], device: device, kind: 'driver')
        end
      end

      device.update_attributes(scanned_drivers: true)
    end
  end
end
