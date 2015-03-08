class SlidesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :update, :create, :destroy]

  def index
    @active_slides = Slide.where("active > 0").order('`order` ASC')
    @inactive_slides = Slide.where("active = 0 OR active IS NULL").order('image_file_name ASC')
  end

  def new
#    if current_user
      @slide = Slide.new
#    else
#      redirect_to root_path
#    end
    render :layout => false   
  end

  def update
    puts params
    if (params.has_key?(:active) && params.has_key?(:id))
      slide = Slide.find(params[:id])
      slide.active = params[:active]
      slide.save
    end
    render :json => { :data => {}, :err => 0, :msg => 'ok'}
  end

  def create
#    if current_user
      @slide = Slide.new(slide_params)
      
      @slide.save
      redirect_to :slides => 'index'
#    else
#      redirect_to root_path
#    end
  end

  def destroy
#    if current_user
      Slide.find(params[:id]).destroy
      
      render :json => { :data => {}, :err => 0, :msg => 'ok'}
#    else
#      redirect_to root_path
#    end
  end

  def test
    @slides = Slide.where("active > 0").order('`order` ASC')
  end

  private
    def slide_params
      params.require(:slide).permit(:image)
    end

end
