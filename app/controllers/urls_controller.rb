class UrlsController < ApplicationController
  def new
    @url = Url.new
  end

  def create
    @url = Url.new(url_params)
    @url.slugify_url

    if @url.new_url?
      @url.save
    end
  end

  private

  def url_params
    params.require(:url).permit(:original_url)
  end
end
