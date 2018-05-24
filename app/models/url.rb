class Url < ApplicationRecord
  validates_format_of :original_url,
    with: /\A(?:(?:http|https):\/\/)?([-a-zA-Z0-9.]{2,256}\.[a-z]{2,4})\b(?:\/[-a-zA-Z0-9@,!:%_\+.~#?&\/\/=]*)?\z/

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

  private

  def generate_short_url
		self.shorten_url = loop do
			random_str = SecureRandom.base58(7)
			break random_str unless self.class.exists?(shorten_url: random_str)
		end
  end
end
