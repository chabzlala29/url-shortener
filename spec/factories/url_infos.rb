FactoryGirl.define do
  factory :url_infos do
    ip { "#{rand(200)}.#{rand(200)}.#{rand(200)}.#{rand(200)}" }
    city { FFaker::Address.city }
    country { FFaker::Address.country }
    url
    last_visited_at { Time.zone.now }
    device { ["Macintosh", "Samsung", "Iphone"].sample }
    browser { ["Chrome", "Firefox", "Internet Explorer"].sample }
  end
end
