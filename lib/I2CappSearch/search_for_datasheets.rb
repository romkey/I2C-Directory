require 'I2CappSearch/search'

module I2CappSearch
  def self.search_for_datasheets(part_number)
    I2CappSearch.search "#{part_number} data sheet", "pdf"
  end
end
