class UsersController < ApplicationController  
  layout "admin"
  
  # MAKES SURE USER IS LOGGED-IN BEFORE ADMIN PAGE WILL LOAD

  before_filter :session_check

  def session_check
    if session[:user_id] == nil
      redirect_to ("/login?error=Oops! Looks like you need to login first.")
    end
  end
  
  # MAKES SURE USER LEVEL ONE OR TWO PRIVILEGE BEFORE CAN DELETE

  before_filter :privilege_check, only: [:delete_find, :delete_choice, :deleteconfirm, :delete, :new, :create]

  def privilege_check
    if session[:privilege] > 1
      redirect_to ("/login?error=Looks like you might need to check your privilege; you don't seem to have permission to do that. :(.")
    end
  end
  
  ############################################
  # ADD NEW USER
  
  # Add new item form
  
  def new
    @user = User.new
    @users_array = User.select("email")

    
    render "new"
  end
  
  # 'post' request that saves changes from new item form

  def create
    params["user"]["user"].downcase!
    params["user"]["user"].strip!
    params["user"]["definition"].strip!
    params["user"]["phonetic"].strip!
    params["user"]["user_id"] = session[:user_id]

    new_item = User.new(params["user"])

    if new_item.valid?
      new_item.save
      @object = new_item   
      @success_message = "Your user was successfully added:"
        
      # Tags user with "user"
      item_keyword = Keyword.find_by_keyword("user")
      KeywordItem.create({"keyword_id"=>item_keyword.id, "item_type"=>"User", "item_id"=>new_item.id})

      # Keyword message      
      @add_keywords = "<hr></hr><h3><em>Thank you!</em></h3><p>Your new user was automatically tagged:
                      <ul><li><strong>\"user\"</strong></li></ul>
                      <br>Go <a href='/admin/tags/change?item_id=#{@object.id}&class=User'>here</a> to add more keywords to describe this user.</p>"

      render "user_success", layout: "admin"
  
    else
      @error_messages = new_item.errors.to_a
      
      render "new"
    end
  end 
  
  ###########################################
  # UPDATE USER
  
  # Choose which item to update
  
  def update_find
    @user = User.new
    @users_array = User.select("id, user")
        
    render "update_find"
  end 
  
  # Sends choice to edit path
  
  def update_choice
    redirect_to ("/admin/users/#{params["id"]}/edit")
  end
  
  # Form to edit item
  
  def edit
    @user = User.new
    @new_item = User.find_by_id(params["id"])
  end 
  
  # 'put' request that saves updates
  
  def update
    params["user"]["user_id"] = session[:user_id]
    params["user"]["user"].strip!
    params["user"]["definition"].strip!
    params["user"]["phonetic"].strip!
    
    existing_item = User.find_by_id(params["user"]["id"]) #object of existing excerpt
  
    if existing_item.update_attributes(params["user"])
      @object = existing_item
      @success_message = "The user was successfully updated:"
      @add_keywords = "<hr></hr><h3><em>Thank you!</em></h3><p>Here are the current keywords: <br><strong><ul><li>#{existing_item.get_keywords.join('</li><li>')}</li></ul></strong><br>
                      <a href='/assign_tag'>Add more keywords</a> to describe this excerpt, if you'd like.</p>"

      render "user_success"
  
    else 
      @error_messages = existing_item.errors.to_a
      render "edit"
  
    end
  end 
  
  ###########################################
  # DELETE USER
  
  # Choose which item to delete
  
  def delete_find
    @user = User.new
    @users_array = User.select("id, user")
    
    render "delete_find"
  end 
  
  # Sends choice to delete path
  
  def delete_choice
    redirect_to ("/admin/users/#{params["id"]}/delete")
  end
  
  # Confirms that the user wants to delete the item
  
  def deleteconfirm
    @user = User.new
    @new_item = User.find_by_id(params["id"])
    
    render "delete_confirm"
  end
  
  # 'delete' request that actually deletes the chosen item
  
  def delete
    @object = User.find(params["user"]["id"])
    @id = @object.id
    
    if @object.destroy
    
      @success_message = "The user was successfully deleted:"
      @add_keywords = ""
      
      # DELETE KEYWORD PAIRINGS FROM TABLE
      
      defunct_keywords = KeywordItem.where("item_type = ? AND item_id = ?", "User", @id)
      
      if defunct_keywords != []
        defunct_keywords.each {|record| record.destroy}
      end

      render "user_success"
      
    else
      admins = (User.where("privilege = 1").collect {|admin| "#{admin.user_name}, #{admin.email}"}).join("<br>")
      @error_messages = "Something went wrong; please contact a Level One administrator:<br><br>" + admins
      
      render "delete_find"
    end
  end 
  
  
 
end