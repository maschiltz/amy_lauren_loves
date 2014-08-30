class ImageLinksController < ApplicationController

  def new
    if current_user
      @image_link = ImageLink.new
    else
      redirect_to root_path
    end
  end

  def list
    @image_links = ImageLink.all()
    @list = @image_links.sort_by { |item| item[:posted] }.reverse
    render "site/index"
  end

  def edit
    if current_user
      @image_link = ImageLink.find(params[:id])
    else
      redirect_to root_path
    end
  end

  def update
    if current_user
      @image_link = ImageLink.find(params[:id])
      if params[:image_link][:link] && params[:image_link][:link] !~ /\Ahttp:\/\//
        params[:image_link][:link] = "http://#{params[:image_link][:link]}"
      end

      if params[:image_link][:posted] == ''
        params[:image_link][:posted] = Time.now
      end      
        
      if params[:image_link][:posted] =~ /\A(\d{2})\/(\d{2})\/(\d{4})\z/
        params[:image_link][:posted] = "#{$3}-#{$1}-#{$2}"
      end


      if @image_link.update(image_link_params)
        redirect_to @image_link
      else
        render 'edit'
      end      
    else
      redirect_to root_path
    end
  end

  def create
    if current_user

      if params[:image_link][:link] && params[:image_link][:link] !~ /\Ahttp:\/\//
        params[:image_link][:link] = "http://#{params[:image_link][:link]}"
      end

      if params[:image_link][:posted] == ''
        params[:image_link][:posted] = Time.now
      end      
        
      if params[:image_link][:posted] =~ /\A(\d{2})\/(\d{2})\/(\d{4})\z/
        params[:image_link][:posted] = "#{$3}-#{$1}-#{$2}"
      end
      @image_link = ImageLink.new(image_link_params)
      
      @image_link.save
      redirect_to @image_link
    else
      redirect_to root_path
    end
  end

  def index
    if current_user
      @image_links = ImageLink.all
    else
      redirect_to root_path
    end
  end

  def show
    @image_link = ImageLink.find(params[:id])
  end

  private
    def image_link_params
      params.require(:image_link).permit(:title, :link, :image, :posted)
    end
end
