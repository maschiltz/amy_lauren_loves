class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.create(contact_params)
    UserMailer.new_contact(@contact).deliver
 
    redirect_to root_url, notice: "Your contact information has been submitted."
  end

  private
    def contact_params
      params.require(:contact).permit(:name, :phone, :email, :body, :heard)
    end

end
