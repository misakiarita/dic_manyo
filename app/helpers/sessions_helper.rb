module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
      
  def logged_in?
      current_user.present?
  end

  def admin_user?
    current_user.admin == true
  end
end
