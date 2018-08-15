#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "I2C Device Directory"
    xml.link "https://i2cdevices.org"
    xml.author "John Romkey"
    xml.description "Arduino, ESP8266, I2C, TwoWire"
    xml.language "en-us"
    xml.ttl "30"

    @devices.each do |device|
      xml.item do
        xml.title device.part_number
        xml.author device.manufacturer
        xml.pubDate device.created_at.to_s(:rfc822)
        xml.link "https://i2cdevices.org/device/" + device.slug
        xml.guid device.id

	text = "<p>" + device.friendly_name + "</p>"

        xml.description text

      end
    end
  end
end