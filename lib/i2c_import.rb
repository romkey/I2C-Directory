require 'nokogiri'
require 'open-uri'
require 'json'
require 'pp'

module I2CImport
  def self.download_page
    url = "https://learn.adafruit.com/i2c-addresses/the-list"

    open(url)
  end

  def self.process_page(page)
    html = Nokogiri::HTML page

    content = html.css('.page-content')
    lines = content.css('li')

    results = []
    lines.each do |line|
      text = line.text
      text.gsub!("\n", "")

      matches = text.match /([\w|\-|\/]+)\s+([\w\-\s|\/]+)\s+\(([\w|\-|\s|,]+)\)/
      unless matches
        next
      end

      addresses = self._get_addresses matches[3]
      results.push({ name: matches[1], description: matches[2], addresses: addresses })
    end

    results
  end

  def self._get_addresses(text)
    addresses = self._match_one_address text
    return addresses if addresses

    addresses = self._match_two text
    return addresses if addresses

    addresses = self._match_address_range text
    if addresses
      return addresses
    end

    addresses = self._match_many text
    if addresses
      return addresses
    end
  end

  def self._match_one_address(text)
    matches = text.match /(\w+)^/
    return [ matches[1] ] if matches
    
    matches = text.match /(\w+) only/
    return [ matches[1] ] if matches
  end

  def self._match_two(text)
    matches = text.match /(\w+)\s+or\s+(\w+)/
    return [ matches[1], matches[2] ] if matches
  end

  def self._match_address_range(text)
    matches = text.match /(\w+)\s+\-\s+(\w+)/
    if matches
      range = Range.new matches[1].to_i(16), matches[2].to_i(16)
      return range.to_a.map { |addr| "0x%02x" % addr }
    end
  end

  def self._match_many(text)
    return unless text.include? ' or '

    new_text = text.gsub(',', '')
    new_text.gsub!('or', '')

    return new_text.split(/s+/)
  end
end
