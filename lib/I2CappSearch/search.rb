require 'net/http'
require 'uri'
require 'dotenv/load'

require 'pp'

part_number = 'SAA9056'


module I2CappSearch
  def self.search(term, type)
    uri = URI.parse 'https://www.googleapis.com/customsearch/v1'

    args = { key: ENV['GOOGLE_CUSTOM_SEARCH_API_KEY'],
             cx: ENV['GOOGLE_CUSTOM_SEARCH_ENGINE_ID'],
             fileType: type,
             
             q: term
           }

    uri.query = URI.encode_www_form(args)

    puts uri.to_s

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(uri.request_uri)

    response = http.request(request)
    if response.code != "200"
      puts response.code
      return nil
    end

    results = JSON.parse response.body
    pp results
    pages = []
    results["items"].each do |item|
      puts "title #{item['title']} url #{item['link']}"
      pages.push({ title: item['title'], link: item['link'] })
    end

    return pages
  end
end
