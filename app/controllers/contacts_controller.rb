class ContactsController < ApplicationController

  def new
    @contact = Contact.new
    @randa = 1+rand(10)
    @randb = 1+rand(10)
  end

  def create
    if (params[:contact][:randa].to_i + params[:contact][:randb].to_i) == params[:contact][:answer].to_i
      @contact = Contact.create(contact_params)
      UserMailer.new_contact(@contact).deliver
    end

    redirect_to root_url, notice: "Your contact information has been submitted."
  end

  private
    def contact_params
      params.require(:contact).permit(:name, :phone, :email, :body, :heard)
    end

end
