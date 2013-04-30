class User < ActiveRecord::Base
  attr_accessible :login, :name, :password, :password_confirmation

  acts_as_authentic do |c|
    c.validate_email_field          = false
    c.require_password_confirmation = true
  end

end
