require 'I2CappSearch/search'

module I2CappSearch
  def self.search_for_drivers(part_number)
    I2CappSearch.search "#{part_number} github arduino OR lua OR micropython OR C OR C++ OR raspberry", ""
  end
end
