# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
(0x00 .. 0x7f).each do |address|
  puts address
  Address.create address: address
end

Address.find_by(address: 0x00).update(reserved: true, notes: 'General Call Address')
Address.find_by(address: 0x01).update(reserved: true, notes: 'CBUS compatability')
Address.find_by(address: 0x02).update(reserved: true, notes: 'I2C variants')
Address.find_by(address: 0x03).update(reserved: true, notes: 'Future Use')
Address.where('address >= 4 AND address <= 7').update(reserved: true, notes: 'HS-mode master')
# 0x78 - 0x7B
Address.where('address >= 120 AND address <= 123').update(reserved: true, notes: '10-bit I2C address')
# 0x7c - 0x7F
Address.where('address >= 124 AND address <= 127').update(reserved: true, notes: 'Future use')
