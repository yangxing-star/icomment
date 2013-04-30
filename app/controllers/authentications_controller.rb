# encoding: utf-8
class AuthenticationsController < ApplicationController
  include SimpleCaptcha::ControllerHelpers
  #----------------------------------------------------------------------------
  def new
    @authentication = Authentication.new
  end

  #----------------------------------------------------------------------------
  def show
    
  end

  def create
    Authentication.authenticate_with = User
    @authentication = Authentication.new(params[:authentication])
    #if simple_captcha_valid?
      if @authentication.save
        user = @authentication.record
        result = { :success          => true,
                   :msg              => '登录成功！',
                   :login            => user.login
                  }
      else
        result = { :success => false,:msg=> @authentication.errors.messages.values.join }
      end
    #else
    #  result = { :success => false, :msg=> '验证码输入错误'}
    #end
      
    respond_to do |format|
      format.json { render :json => result }
    end
  end

  # The login form gets submitted to :update action when @authentication is
  # saved (@authentication != nil) but the user is suspended.
  #----------------------------------------------------------------------------
  alias :update :create

  #----------------------------------------------------------------------------
  def destroy
    current_user_session.destroy
    respond_to do |format|
      format.json { render :json => {:success => true,:msg => '您已成功退出系统'} }
    end
  end
end