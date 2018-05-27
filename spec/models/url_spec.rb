require 'rails_helper'

RSpec.describe Url, type: :model do
  it { is_expected.to validate_presence_of(:original_url) }
  it { is_expected.to have_many(:url_infos) }

  let(:original_url) { "http://somerandomurl.com" }
  let(:url) { Url.new(original_url: original_url) }

  describe "hooks" do
    it "generates short url before create" do
      url.save
      expect(url.reload.shorten_url).to be_present
    end
  end

  describe "DEFAULT_DEVICE_NAME" do
    it { expect(Url::DEFAULT_DEVICE_NAME).to eq "Unknown" }
  end

  describe "should not save if url is not valid" do
    let(:original_url) { "wrongurl" }

    it { expect(url.valid?).to be_falsey }
  end

  describe "Methods" do
    describe "#last_visited_at" do
      let!(:url) { create(:url) }
      let!(:url_info) { create(:url_info, url: url) }
      let(:result) { url.last_visited_at }

      it { expect(result).to eq url_info.last_visited_at }

      describe "no url_info" do
        let(:url_info) { nil }

        it { expect(result).to eq nil }
      end
    end

    describe "#new_url?" do
      let(:url) { create(:url) }
      let(:result) { url.new_url? }

      it { expect(result).to eq(false) }

      describe "new url" do
        let(:url) { build(:url) }

        it { expect(result).to eq(true) }
      end
    end

    describe "#duplicated_url" do
      let(:slugified_url) { "http://test.com" }
      let!(:old_url) { create(:url, slugified_url: slugified_url) }
      let(:url) { build(:url, slugified_url: slugified_url) }
      let(:result) { url.duplicated_url }

      it { expect(result).to eq(old_url) }

      describe "different url" do
        let!(:old_url) { create(:url) }

        it { expect(result).to eq(nil) }
      end
    end

    describe "#slugify_url" do
      let(:url) { create(:url, original_url: original_url) }
      let(:original_url) { "http://Test.com" }
      let(:result) { url.slugify_url }

      it { expect(result).to eq("http://test.com") }

      describe "https" do
        let(:original_url) { "https://Test.com" }

        it { expect(result).to eq("http://test.com") }
      end

      describe "www" do
        let(:original_url) { "www.Test.com" }

        it { expect(result).to eq("http://test.com") }
      end
    end

    describe "#update_info!" do
      before(:each) do
        let(:location_data) do
          { city: "Test", region: "Region 1", country: "America", postal: "1223" }
        end
        let(:sample_request) do
          OpenStruct.new({
            location: {
              data: location_data,
              env: {
                "HTTP_USER_AGENT" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36"
              }
            },
          })
        end
        let(:url) { create(:url) }

        it "updates info" do
          url.update_info!(sample_request)
          url_info = url.reload.url_infos.first

          expect(url_info.city).to eq location_data.city
          expect(url_info.region).to eq location_data.region
          expect(url_info.country).to eq location_data.country
          expect(url_info.postal).to eq location_data.postal
        end
      end
    end

    describe "#generate_short_url" do
      let(:generate_short_url) { build(:url) }
      let(:result) { url.shorten_url }

      it { expect(result).to eq nil}
    end
  end
end
