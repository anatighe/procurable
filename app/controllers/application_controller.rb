class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  rescue_from CanCan::AccessDenied do |exeption|
    flash[:error] = "Access denied."
    redirect_to root_url
  end

private

  def authenticate_store_owner(store)
    if current_user.id != store.user_id
      redirect_to new_user_session_path, alert: "You don't have permission to do that"
    end
  end
end

