module ApplicationHelper
  include Pagy::Frontend

  # Bootstrap Icons helper: icon("rss") => <i class="bi bi-rss"></i>
  def icon(name, **options)
    classes = [ "bi", "bi-#{name}", options.delete(:class) ].compact.join(" ")
    tag.i("", class: classes, **options)
  end
end
