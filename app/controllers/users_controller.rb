# encoding: utf-8
class UsersController < ApplicationController

  def create
    user = User.new(params[:user])
    if user.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  # 检查用户session
  def check_session
    if current_user
      json_data = {:success => true,
                   :login   => current_user.login,
                   :user_id => current_user.id}
    else 
      json_data = {:success => false}
    end  
    respond_to do |format|
      format.json { render :json => json_data}
    end
  end

  # 注册用户名检查
  def signup_login_check
    user = User.where(:login => params[:login]).first
    if user
      result = { :success => false, :msg => "用户名已存在" }
    else
      result = { :success => true,  :msg => "恭喜你,该用户名可以使用" }
    end
    respond_to do |format|
      format.json { render :json => result}
    end
  end

end
