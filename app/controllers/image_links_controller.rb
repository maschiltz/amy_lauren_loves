class ImageLinksController < ApplicationController

  def new
    if current_user
      @image_link = ImageLink.new
    else
      redirect_to root_path
    end
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
      puts '000000'
      puts params[:link]
      puts params.inspect
      if params[:image_link][:link] && params[:image_link][:link] !~ /\Ahttp:\/\//
          puts '22222'
          params[:image_link][:link] = "http://#{params[:image_link][:link]}"
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
      @image_link = ImageLink.new(image_link_params)

      if params[:link] && params !~ /\Ahttp:\/\//
        params[:link] = "http://#{params[:link]}"
      end

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
      params.require(:image_link).permit(:title, :link, :image)
    end
end
