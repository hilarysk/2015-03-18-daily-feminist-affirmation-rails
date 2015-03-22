class ExcerptsController < ApplicationController  
  layout "admin"
  
  # MAKES SURE USER IS LOGGED-IN BEFORE ADMIN PAGE WILL LOAD
  
  # before_filter :session_check
  #
  # def session_check
  #   if session[:user_id] == nil
  #     redirect_to ("/login?error=Oops! Looks like you need to login first.")
  #   end
  # end
  
  # Sets instance variables for certain pages
  
  before_filter :set_variables, :only => [:new, :update_find, :edit]
  
  def set_variables
    @person_names_ids = Person.select("id, person")
    @excerpt_sources = Excerpt.uniq.pluck("source")
    # if session[:user_id] == nil
 #      redirect_to ("/login?error=Oops! Looks like you need to login first.")
 #    end
  end
  
  ############################################
  
  # Add new item form
  
  def new
    @excerpt = Excerpt.new
    @path = request.path_info
    
    if params["source"].nil? == false
      @text_array = Excerpt.where("source = ?", params["source"])
      @excerpt_choice = "sources_for_new_excerpt"
    end
    
    render "new"
  end
  
  # 'post' request that saves changes from new item form

  def create
    params["excerpt"]["excerpt"].strip!

    if params["excerpt"]["source"] == ""
      params["excerpt"]["source"] = params["source1"]
      params["excerpt"].delete("source1")
      params["excerpt"]["source"].strip!
    else
      params["excerpt"].delete("source1")
      params["excerpt"]["source"].strip!
      
    end  

    params["user_id"] = session[:user_id]

    new_excerpt = Excerpt.new(params["excerpt"])

    if new_excerpt.valid?
      new_excerpt.save
      @object = new_excerpt   
      @person = Person.find_by_id(params["excerpt"]["person_id"]).person
      @success_message = "Your excerpt was successfully added:"
      
      ################### PULL OUT INTO SELF METHOD FOR EACH CLASS ###########################
  
      @source_keyword = Keyword.find_by_keyword(params["excerpt"]["source"])
      # If source for the new excerpt isn't already a keyword, it makes a  new one
      if @source_keyword == nil
        @source_keyword = Keyword.create({"keyword" => "#{params["excerpt"]["source"]}"})
      end
  
      # Tags excerpt with source
      KeywordItem.create({"keyword_id"=>@source_keyword.id, "item_type"=>"Excerpt", "item_id"=>new_excerpt.id})
      # Tags excerpt with person
      person_keyword = Keyword.find_by_keyword(new_excerpt.person.person)
      KeywordItem.create({"keyword_id"=>person_keyword.id, "item_type"=>"Excerpt", "item_id"=>new_excerpt.id})
      # Tags excerpt with "excerpt"
      excerpt_keyword = Keyword.find_by_keyword("excerpt")
      KeywordItem.create({"keyword_id"=>excerpt_keyword.id, "item_type"=>"Excerpt", "item_id"=>new_excerpt.id})
  
      ########################################################################################
 
      # Keyword message      
      @add_keywords = "<hr></hr><h3><em>Thank you!</em></h3><p>Your new excerpt was automatically tagged:
                      <ul><li><strong>\"#{@source_keyword.keyword}\"</strong></li>
                      <li><strong>\"#{person_keyword.keyword}\"</strong></li>
                      <li><strong>\"excerpt\"</strong></li></ul>
                      <br>Go <a href='/assign_tag'>here</a> to add more keywords to describe this excerpt.</p>"

      render "new_excerpt_success", layout: "admin"
  
    else
      @error_messages = new_excerpt.errors.to_a
      
      render "new_excerpt"
    end
  end 
  
  # Choose which item to update
  
  def update_find
    @excerpt = Excerpt.new
    @path = request.path_info

    if params["source"].nil? == false
      @text_array = Excerpt.where("source = ?", params["source"])
      @excerpt_choice = "sources_for_update_excerpt"
      @excerpt = params["source"]
    end
    
    render "update_find"
  end 
  
  # Sends choice to edit path
  
  def update_choice
    #at this point, session is an empty hash - how to carry over from other controller?
    redirect_to ("/admin/excerpts/#{params["id"]}/edit")
  end
  
  # Form to edit item
  
  def edit
    @excerpt = Excerpt.new
    info = Excerpt.find_by_id(params["id"]).as_json #not sure if this will work .... need to redirect with params?
    @new_ex = Excerpt.new(info)
  end 
  
  # 'put' request that saves updates
  
  def update

  end 
  
  # Choose which item to delete
  
  def delete_choice

  end 
  
  # 'delete' request that actually deletes the chosen item
  
  def delete

  end 
  
end
    
  