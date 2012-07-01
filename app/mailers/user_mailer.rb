class UserMailer < ActionMailer::Base
  default from: "info@example.com"
  
  def welcome_email(user)
    @user = user
    @url = 
    @url = "https://strong-mountain-1211.herokuapp.com/signin" #What about when it's localhost?
    mail(:to => user.email, :subject => "Look who can send emails on login")
  end
end
