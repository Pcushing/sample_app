# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
SampleApp::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => "Pcushing",
  :password => "bootcamp12",
  :domain => "strong-mountain-1211.herokuapp.com",
  :address => "smtp.sendgrid.net",
  :port => 587, 
  :authentication => :plain,
  :enable_starttls_auto => true
}