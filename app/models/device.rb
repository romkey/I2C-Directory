class Device < ApplicationRecord
  has_and_belongs_to_many :address
  has_many :datasheet_suggestions

  before_validation :ensure_has_slug

  scope :suggestions, -> { where(suggestion: true) }
  scope :published, -> { where(suggestion: false) }
  scope :needs_datasheet, -> { where("datasheet = '' OR datasheet IS NULL ") }

  def to_amazon_link
    "https://www.amazon.com/s?field-keywords=#{part_number}"
  end

  def to_slug(string)
    string.parameterize.truncate(80, omission: '')
  end

  def to_param
    slug
  end


private
  def ensure_has_slug
    if slug.nil? || slug.empty?
      self.slug = to_slug(part_number)
    end
  end

  def self.import(csv_file)
    i = 0

    CSV.foreach(csv_file.path) do |row|
      Device.create! manufacturer: row[0], part_number: row[1], friendly_name: row[2]
      i += 1
    end

    return i
  end
end
