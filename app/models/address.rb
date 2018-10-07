class Address < ApplicationRecord
  has_and_belongs_to_many :device

  before_validation :ensure_has_slug

  def to_s
    "0x%02x" % address
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
      self.slug = to_slug(to_s())
    end
  end
end
