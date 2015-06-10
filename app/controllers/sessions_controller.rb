class SessionsController < ApplicationController

  def login
    if request.post?
      user = Instructor.find_by_email(params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to dashboard_instructor_path, notice: "Login Successful"
      else
        flash.now[:notice] = "User and Password do not match our records."
      end
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to sessions_login_path, notice: "Logout Successful"
  end

end
