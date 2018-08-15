#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "I2C Device Directory"
    xml.link "https://i2cdevices.org"
    xml.author '"John Romkey" <romkey+i2cdevices@romkey.com>'
    xml.description "Arduino, ESP8266, I2C, TwoWire"
    xml.language "en-us"
    xml.ttl "30"

    @devices.each do |device|
      xml.item do
        xml.title device.part_number
        xml.pubDate device.created_at.to_s(:rfc822)
        xml.link "https://i2cdevices.org/devices/" + device.slug
        xml.guid "https://i2cdevices.org/devices/" + device.slug

	text = "<p>" + (device.manufacturer ||  "") + " " + device.friendly_name + "</p>"

        xml.description text

      end
    end
  end
end