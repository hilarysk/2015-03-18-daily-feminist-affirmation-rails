class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # CHECKS TO MAKE SURE USER IS IN SYSTEM; IF NOT, RETURNS THEM TO LOGIN PAGE WITH ERROR MESSAGE
  
  def user_verify
    user = User.find_by_email(params["email"]) 
           
    if BCrypt::Password.new(user.password) == params["password"].to_s
      session[:user_id] = user.id
      session[:email] = user.email
      session[:privilege] = user.privilege
      session[:name] = user.user_name
      redirect_to ("/admin/update_database")
      
    else 
      redirect_to ("/login?error=We couldn't find you in the system; please try again.")    
    end

  end
  
  # LOGOUT ROUTE ADDS LOGOUT MESSAGE LOADS LOGIN
  
  def logout
    @logout_message = "You have successfully logged out. Thanks for contributing!"
    render "login", layout: "public"
  end
  
  
  
end
