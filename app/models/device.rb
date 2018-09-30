class Device < ApplicationRecord
  has_and_belongs_to_many :address

  before_validation :ensure_has_slug

  scope :suggestions, -> { where(suggestion: true) }
  scope :published, -> { where(suggestion: false) }

  def to_amazon_link
    "https://www.amazon.com/s?field-keywords=#{part_number}"
  end

private
  def ensure_has_slug
    if slug.nil? || slug.empty?
      self.slug = to_slug(part_number)
    end
  end
end
