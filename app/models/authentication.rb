# encoding: utf-8
class Authentication < Authlogic::Session::Base
  authenticate_with User
  

  private

  # Override Authlogic's validate_by_password() to allow blank passwords. See
  # authlogic/lib/authlogic/session/pasword.rb for details.
  #----------------------------------------------------------------------------
  def validate_by_password
    self.invalid_password = false
    self.attempted_record = search_for_record(find_by_login_method, send(login_field))
    if self.attempted_record.blank?
      errors.add(login_field, "找不到该帐号！")
    else
      # Run password verification first, but then adjust the validity if both
      # password hash and password field are blank.
      self.invalid_password = !self.attempted_record.send(verify_password_method, send("protected_#{password_field}"))
      #if self.attempted_record.password_hash.blank? && send("protected_#{password_field}").blank?
      #  self.invalid_password = false
      #end
      if self.invalid_password?
        errors.add(password_field, "密码不正确！")
      end
    end
  end 

end