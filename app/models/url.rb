class Url < ApplicationRecord
  validates_format_of :original_url,
    with: /\A(?:(?:http|https):\/\/)?([-a-zA-Z0-9.]{2,256}\.[a-z]{2,4})\b(?:\/[-a-zA-Z0-9@,!:%_\+.~#?&\/\/=]*)?\z/

  before_create :generate_short_url

  private

  def generate_short_url
		self.shorten_url = loop do
			random_str = SecureRandom.base58(7)
			break random_str unless self.class.exists?(shorten_url: random_str)
		end
  end
end
