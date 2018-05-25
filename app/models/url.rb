class Url < ApplicationRecord
  validates_format_of :original_url,
    with: /\A(?:(?:http|https):\/\/)?([-a-zA-Z0-9.]{2,256}\.[a-z]{2,4})\b(?:\/[-a-zA-Z0-9@,!:%_\+.~#?&\/\/=]*)?\z/
  validates :original_url, presence: true
  has_many :url_infos

  DEFAULT_DEVICE_NAME = "Unknown"

  before_create :generate_short_url

  def new_url?
    duplicated_url.nil?
  end

  def duplicated_url
    Url.find_by(slugified_url: self.slugified_url)
  end

  def slugify_url
    self.slugified_url = original_url.downcase.gsub(/(www\.)|(https?:\/\/)/, "")
    self.slugified_url.slice!(-1) if slugified_url[-1] == "/"
    self.slugified_url = "http://#{self.slugified_url}"
  end

  def update_info!(request)
    location_info = request.location.data
    browser_info = Browser.new(request.env["HTTP_USER_AGENT"])

    # Assign location info
    url_info = url_infos.find_or_initialize_by(ip: location_info["ip"])
    url_info.last_visited_at = Time.zone.now
    url_info.city = location_info["city"]
    url_info.region = location_info["region"]
    url_info.country = location_info["country"]
    url_info.loc = location_info["loc"]
    url_info.postal = location_info["postal"]

    # Assign Device and Browser info
    url_info.browser = browser_info.name
    url_info.device_name = browser_info.platform.name rescue DEFAULT_DEVICE_NAME

    url_info.save
  end

  private

  def generate_short_url
		self.shorten_url = loop do
			random_str = SecureRandom.base58(7)
			break random_str unless self.class.exists?(shorten_url: random_str)
		end
  end
end
