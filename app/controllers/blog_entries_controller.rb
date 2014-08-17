class BlogEntriesController < ApplicationController

  def new
    @blog_entry = BlogEntry.new
  end

  def create
    @blog_entry = BlogEntry.new(blog_entry_params)

    if params[:blog_entry][:image]
      image = params[:blog_entry][:image]
      File.open(Rails.root.join('public','blog_images',image.original_filename), 'wb') do |file|
        file.write(image.read)
      end
      @blog_entry[:image] = image.original_filename
    end

    if params[:blog_entry][:posted]
      if params[:blog_entry][:posted] =~ /\A(\d{2})\/(\d{2})\/(\d{4})\z/
        params[:blog_entry][:posted] = "#{$3}-#{$1}-#{$2}"
      end
    end

puts @blog_entry
    temp = @blog_entry.save
    puts temp
    puts @blog_entry.errors.inspect
    redirect_to @blog_entry
  end

  def show
    @blog_entry = BlogEntry.find(params[:id])
  end

  def index
    @blog_entries = BlogEntry.all
  end

  private
    def blog_entry_params
      params.require(:blog_entry).permit(:title, :text, :posted)
    end
end
