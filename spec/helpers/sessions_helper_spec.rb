require 'spec_helper'

describe SessionsHelper do
  
  RSpec::Matchers.define :have_error_message do |message|
    match do |page|
      page.should have_selector('div.alert.alert-error', text: message)
    end
  end

end