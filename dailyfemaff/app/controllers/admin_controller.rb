class AdminController < ApplicationController
  # pass in params["excerpt"] etc. instead of just params - namespacing
  #use the if error.messages.key.include? error["name"] etc., make the message the placeholder in form
  
  # Call the filters only for the actions listed in :only
  #   before_filter :session_check, :only => [:show, :edit, :update, :destroy]
  

  ##################################################
  
  # MAKES SURE USER IS LOGGED-IN BEFORE ADMIN PAGE WILL LOAD
  
  before_filter :session_check, :except => [:login, :login_forgot, :user_verify, :logout]
  
  def session_check
    if session[:user_id] == nil
      redirect_to ("/login?error=Oops! Looks like you need to login first.")
    end
  end
  
  # BEFORE LOGOUT, RESETS SESSION  
  
  before_filter :clear_session, :only => :logout
  
  def clear_session
    session[:user_id] = nil
    session[:email] = nil
    session[:privilege] = nil
    session[:user_name] = nil
    session[:message] = nil
  end
  
  # AFTER LOADS DATABASE PAGE FIRST TIME, CLEARS SESSION MESSAGE
  
  after_filter :clear_session_message, :only => :update_database
  
  def clear_session_message
    session[:message] = nil
  end 
  
  ##################################################
  
  # PAGE FOR FUNCTIONALITIES THAT AREN'T, YOU KNOW, FUNCTIONAL YET
  
  def coming_soon
    render layout: "admin"
  end
  
  # WHERE USER LOGS IN
  
  def login
    @fail_message = params["error"]
    render layout: "public"
  end
  
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
  
  # LOADS PAGE WITH ADMINISTRATIVE ACTIONS
  
  def update_database
    if session[:privilege] == 1
      @create_option = "<li><a href='/admin/user/new'>Add new administrator</a></li>"
      @contrib_option = "<li><a href='/admin/contrib'>See administrator's contributions</a></li>"
    end
  
    @error = params["error"]
    @message = session[:message]
    @name = session[:name]
  end
  
  # LOGOUT ROUTE ADDS LOGOUT MESSAGE LOADS LOGIN
  
  def logout
    @logout_message = "You have successfully logged out. Thanks for contributing!"
    render "login", layout: "public"
  end
  
  # SHOWS EVERYTHING ADDED BY A SPECIFIC CONTRIBUTOR, IN DESCENDING ORDER
  
  def contrib
    @all_admins = User.all
    @path = request.path_info

    if params["id"].nil? == false
      @user = User.find_by_id(params["id"])
      @items = @user.items_array_sorted_descending
      @specific_contrib = "/admin/contrib_partial"
    end
  end
    

end


