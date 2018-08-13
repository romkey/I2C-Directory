# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
[0x00 .. 0x7f ].each do |address|
  Address.create address: address
end

Address.find_by(address: 0x00).update_attributes(reserved: true, notes: 'General Call Address')
Address.find_by(address: 0x01).update_attributes(reserved: true, notes: 'CBUS compatability')
Address.find_by(address: 0x02).update_attributes(reserved: true, notes: 'I2C variants')
Address.find_by(address: 0x03).update_attributes(reserved: true, notes: 'Future Use')
Address.where('address >= 4 AND address <= 7').update_attributes(reserved: true, notes: 'HS-mode master')
Address.where('address >= 0x78 AND address <= 0x7b').update_attributes(reserved: true, notes: '10-bit I2C address')
Address.where('address >= 0x7c AND address <= 0x7f').update_attributes(reserved: true, notes: 'Future use')
