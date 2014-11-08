class UserMailer < ActionMailer::Base
  default from: "amy@amylaurenloves.com"

  def new_contact(contact)
    @contact = contact
    mail(to: 'amy5lauren@gmail.com', subject: 'Contact Requested')
  end
end
