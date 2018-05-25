class UrlInfo < ApplicationRecord
  belongs_to :url

  validates :ip, presence: true

  paginates_per 5
end
