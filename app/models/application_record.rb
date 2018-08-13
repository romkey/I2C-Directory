class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def to_slug(string)
    string.parameterize.truncate(80, omission: '')
  end

  def to_param
    slug
  end
end
