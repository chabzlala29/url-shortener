
RSpec.describe UrlInfo, type: :model do
  it { is_expected.to validate_presence_of(:ip) }
  it { is_expected.to belong_to(:url) }
end
