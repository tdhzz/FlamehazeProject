class SessionsController < ApplicationController

  def new

  end

  def create
    if user = login(params[:email], params[:password])
      update_browser_number user.number
      flash[:notice] = "登录成功"
      redirect_to root_path
    else
      flash[:notice] = "登录失败，请确定信息输入无误"
      redirect_to new_session_path
    end
  end

  def destroy
    logout
    cookies.delete :user_number
    flash[:notice] = "退出成功"
    redirect_to root_path
  end

end
