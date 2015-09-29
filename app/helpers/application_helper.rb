module ApplicationHelper

  def authenticated?
    session[:user_id] != nil
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if authenticated?
  end

  def authorize
    unless authenticated?
      redirect_to new_session_path
    end
  end
end
