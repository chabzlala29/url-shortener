require "rails_helper"

RSpec.describe UrlsController, type: :controller do
  describe "GET show" do
    let(:short_url) { url.shorten_url }
    let(:url) { create(:url) }

    before(:each) { get :show, params: { short_url: short_url } }

    it { expect(response).to be_success }
    it { expect(assigns(:url)).to be_an_instance_of(Url) }
    it { expect(assigns(:url)).to eq(url) }
    it { expect(response).to render_template(:show) }
  end

  describe "GET show as JSON" do
    let(:short_url) { url.shorten_url }
    let(:url) { create(:url) }

    it "return correct data" do
      get :show, params: { short_url: short_url }, format: :json
      json_data = JSON.parse(response.body)
      expect(json_data["id"]).to eq(url.id)
      expect(json_data["original_url"]).to eq(url.original_url)
      expect(json_data["shorten_url"]).to eq(url.shorten_url)
    end
  end

  describe "GET new" do
    before(:each) { get :new }

    it { expect(response).to be_success }
    it { expect(assigns(:url)).to be_a_new(Url) }
    it { expect(response).to render_template(:new) }
  end

  describe "POST create" do
    let(:original_url) { "http://sometest.com" }

    it do
      post :create, params: { url: { original_url: original_url } }, format: :js
      expect(response).to be_success
    end

    it "creates new record" do
      expect {
        post :create, params: { url: { original_url: original_url } }, format: :js
      }.to change(Url, :count).by(1)
    end

    describe "invalid attributes" do
      it do
        expect {
          post :create, format: :js
        }.to raise_error(ActionController::ParameterMissing)
      end
    end

    describe "existing url record" do
      let(:original_url) { "http://existingurl.com" }
      let!(:existing_url) do
        url = Url.new(original_url: "http://existingurl.com")
        url.slugify_url
        url.save
        url
      end

      it "doesn't create new record" do
        expect {
          post :create, params: { url: { original_url: original_url } }, format: :js
        }.to_not change(Url, :count)
      end
    end
  end

  describe "GET index" do
    let(:short_url) { url.shorten_url }
    let(:url) { create(:url) }

    before(:each) { get :index, params: { short_url: short_url } }

    it { expect(response).to redirect_to(url.original_url) }
    it { expect(assigns(:url)).to be_an_instance_of(Url) }
    it { expect(assigns(:url).visits).to eq(1) }
    it { expect(request.session[:sessioned_url_ids]).to eq([url.id]) }
    it { expect(assigns(:url).url_infos.count).to eq(1) }
  end
end
