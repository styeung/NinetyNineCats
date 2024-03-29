class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :signed_in?, :owns_cat?


  private

  def current_user
    return nil unless session[:token]
    @current_user ||= User.find_by_session_token(session[:token])
  end

  def signed_in?
    !!current_user
  end

  def sign_in(user)
    @current_user = user
    session[:token] = user.reset_session_token!
  end

  def sign_out
    current_user.try(:reset_sesion_token!)
    session[:token] = nil
  end


  def require_signed_in!
    redirect_to new_session_url unless signed_in?
  end

  def require_signed_out!
    redirect_to cats_url if signed_in?
  end

  def require_owns_cat!
    cat = Cat.find(params[:id])
    redirect_to cats_url if cat.user_id != current_user.id
  end

  def owns_cat?(cat)
    cat.user_id == current_user.id
  end

end
