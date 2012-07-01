class UserMailer < ActionMailer::Base
  default from: "info@example.com"
  
  def welcome_email(user)
    @user = user
    @url = "https://strong-mountain-1211.herokuapp.com/"    
    mail(:to => user.email, :subject => "Look who can send emails on login now")
    # puts ActionMailer::Base.deliveries.inspect    
  end
  
end
