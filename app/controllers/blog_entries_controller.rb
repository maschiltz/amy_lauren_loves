class BlogEntriesController < ApplicationController

  def new
    if current_user
      @blog_entry = BlogEntry.new
    else
      redirect_to root_path
    end
  end

  def edit
    if current_user
      @blog_entry = BlogEntry.find(params[:id])
    else
      redirect_to root_path
    end
  end

  def update
    if current_user
      @blog_entry = BlogEntry.find(params[:id])

      if params[:blog_entry][:posted]
        if params[:blog_entry][:posted] =~ /\A(\d{2})\/(\d{2})\/(\d{4})\z/
          params[:blog_entry][:posted] = "#{$3}-#{$1}-#{$2}"
        end
      end

      if @blog_entry.update(blog_entry_params)
        redirect_to @blog_entry
      else
        render 'edit'
      end
    else
      redirect_to root_path
    end
  end

  def create
    if current_user
      @blog_entry = BlogEntry.new(blog_entry_params)

      if params[:blog_entry][:posted]
        if params[:blog_entry][:posted] =~ /\A(\d{2})\/(\d{2})\/(\d{4})\z/
          params[:blog_entry][:posted] = "#{$3}-#{$1}-#{$2}"
        end
      end

      @blog_entry.save
      redirect_to @blog_entry
    else
      redirect_to root_path
    end
  end

  def show
    @blog_entry = BlogEntry.find(params[:id])
  end

  def destroy
    if current_user
      @blog_entry = BlogEntry.find(params[:id])
      @blog_entry.destroy
      render :text => "Deleted"
    else
      redirect_to root_path
    end
  end

  def index
    @blog_entries = BlogEntry.all
  end

  private
    def blog_entry_params
      params.require(:blog_entry).permit(:title, :text, :posted, :image)
    end
end
