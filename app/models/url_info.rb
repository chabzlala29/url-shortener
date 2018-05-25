class UrlInfo < ApplicationRecord
  belongs_to :url

  validates :ip, presence: true
end
