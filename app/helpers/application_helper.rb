module ApplicationHelper

  # method that
  def form_group_tag(errors, &block)
    css_class = 'form-group'
    # add ' has error' to CSS string being passed if errors occur
    css_class << ' has-error' if errors.any?
    # content_tag is a Rails helper method that builds HTML and CSS
    content_tag :div, capture(&block), class: css_class
  end
end
