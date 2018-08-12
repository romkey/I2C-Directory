class Device < ApplicationRecord
  has_and_belongs_to_many :address
end
