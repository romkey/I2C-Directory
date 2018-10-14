require 'I2CappSearch/search_for_datasheets'

class SuggestDatasheetsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Device.needs_datasheet.where('scanned = false').limit(10).each do |device|
      pages = I2CappSearch.search_for_datasheets device.part_number

      if pages
        pages.each do |page|
          device.datasheet_suggestions << DatasheetSuggestion.create(title: page[:title], link: page[:link], device: device, kind: 'datasheet')
        end
      end

      device.update_attributes(scanned: true)
    end
  end
end
