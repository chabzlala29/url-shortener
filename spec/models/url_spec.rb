require 'rails_helper'

RSpec.describe Url, type: :model do
  it { is_expected.to validate_presence_of(:original_url) }

  let(:original_url) { "http://somerandomurl.com" }
  let(:url) { Url.new(original_url: original_url) }

  describe "hooks" do
    it "generates short url before create" do
      url.save
      expect(url.reload.shorten_url).to be_present
    end
  end

  describe "should not save if url is not valid" do
    let(:original_url) { "wrongurl" }

    it { expect(url.valid?).to be_falsey }
  end
end
