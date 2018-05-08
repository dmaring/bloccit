module ApplicationHelper

  # method that
  def form_group_tag(errors, &block)
    css_class = 'form-group'
    # add ' has error' to CSS string being passed if errors occur
    css_class << ' has-error' if errors.any?
    # content_tag is a Rails helper method that builds HTML and CSS
    content_tag :div, capture(&block), class: css_class
  end

  def avatar_url(user)
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=48"
  end

end
