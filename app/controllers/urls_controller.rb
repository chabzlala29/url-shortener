class UrlsController < ApplicationController
  def show
    @url = Url.find_by(shorten_url: params[:short_url])
    @url.increment!(:visits, 1)
    @url.update_info!(request)

    redirect_to @url.original_url
  end

  def new
    @url = Url.new
  end

  def create
    @url = Url.new(url_params)
    @url.slugify_url

    if @url.new_url?
      @url.save
    else
      @url = @url.duplicated_url
    end
  end

  private

  def url_params
    params.require(:url).permit(:original_url)
  end
end
