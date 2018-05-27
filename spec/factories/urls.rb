FactoryGirl.define do
  factory :url do
    original_url { "https://#{FFaker::Internet.domain_name}" }
  end
end
