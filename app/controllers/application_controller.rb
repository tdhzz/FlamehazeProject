class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_browser_number

  protected

  def auth_user
    unless logged_in?
      flash[:notice] = "请登录"
      redirect_to new_session_path
    end
  end

  def fetch_home_data
    @categories = Category.grouped_data
    @shopping_cart_count = ShoppingCart.by_user_number(session[:user_number]).count
  end

  def set_browser_number
    number = cookies[:user_number]

    unless number
      if logged_in?
        number = current_user.number
      else
        number = RandomCode.generate_utoken
      end
    end

    update_browser_number number
  end

  def update_browser_number number
    session[:user_number] = cookies.permanent['user_number'] = number
  end
end
