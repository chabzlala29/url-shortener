class UrlsController < ApplicationController
  before_action :set_url, only: [:index, :show]

  def show
    @url_infos = @url.url_infos.page(params[:page])

    respond_to do |f|
      f.html
      f.json { render json: @url, include: [:url_infos] }
    end
  end

  def index
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

  def set_url
    @url = Url.find_by(shorten_url: params[:short_url])
  end
end
