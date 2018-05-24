class UrlsController < ApplicationController
  def show
    redirect_to Url.find_by(shorten_url: params[:short_url]).original_url
  end

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
