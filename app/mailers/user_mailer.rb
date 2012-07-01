class UserMailer < ActionMailer::Base
  default from: "info@example.com"
  
  def welcome_email(user)
    @user = user
    @url = "https://strong-mountain-1211.herokuapp.com/"    
    mail(:to => user.email, :subject => "Look who can send emails on login")
    # mail(:to => "patrick.j.cushing@gmail.com", :subject => "Look who can send emails on login")
  end
  
end
