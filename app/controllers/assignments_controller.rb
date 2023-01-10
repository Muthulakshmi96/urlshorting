class AssignmentsController < ApplicationController
  def index
    @link = ShortenedUrl.new
  end

  def show_url
    redirect_to @url.sanitize_url
  end

  def create
    @url = ShortenedUrl.new
    @url.original_url = params[:original_url]
    @url.sanitize
    if @url.new_url?
      if @url.save
        redirect_to shortened_path(@url.short_url)
      else
        flash[:error] = "check the error below:"
        render 'index'
      end
    else
      flash[:notice] = "A short Link for this url already exit"
      redirect_to shortened_path(@url.find_duplicate.short_url)
    end
  end

  def shortened
    @url = ShortenedUrl.find_by_short_url(params[:short_url])
    host = request.host_with_port
    @orgiginal_url = @url.sanitize_url
    @short_url= host+'/'+@url.short_url
  end
  def ferch_original_url
    fetch_url = ShortenedUrl.find_by_short_url(params[:short_url])
    redirect_to fetch_url.sanitize_url
  end
  
  private
  def find_url
    @url=ShortenedUrl.find_by_short_url(params[:short_url])
  end
  def url_params
    params.require(:url).permit(:orgiginal_url)
  end
end
