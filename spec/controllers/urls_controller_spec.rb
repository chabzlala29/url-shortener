require "rails_helper"

RSpec.describe UrlsController, type: :controller do
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
end
