class Address < ApplicationRecord
  has_and_belongs_to_many :device

  def to_s
    "0x%02x" % address
  end
end
