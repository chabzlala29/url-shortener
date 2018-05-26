module ApplicationHelper
  def full_shorten_url(url)
    "#{request.base_url}/#{url.shorten_url}"
  end
end
