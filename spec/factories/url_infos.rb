FactoryGirl.define do
  factory :url_info do
    ip { "#{rand(200)}.#{rand(200)}.#{rand(200)}.#{rand(200)}" }
    city { FFaker::Address.city }
    country { FFaker::Address.country }
    url
    last_visited_at { Time.zone.now }
    device_name { ["Macintosh", "Samsung", "Iphone"].sample }
    browser { ["Chrome", "Firefox", "Internet Explorer"].sample }
  end
end
