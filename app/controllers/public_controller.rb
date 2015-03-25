class PublicController < ApplicationController
  skip_before_filter :session_check
  
  def home
    render layout: "home"
  end
  
  def yay 
    # item = (Quote.all + Term.all + Excerpt.all + Person.all).sample
    items = []
    
    quote_id = rand(1..Quote.count)
    items.push Quote.find(quote_id)
    
    excerpt_id = rand(1..Excerpt.count)
    items.push Excerpt.find(excerpt_id)
    
    term_id = rand(1..Term.count)
    items.push Term.find(term_id)
    
    person_id = rand(1..Person.count)
    items.push Person.find(person_id)
    
    item = items.sample
    
     # get random of each class and then random of the four
    
    # keywords_array = DATABASE.execute("select keywords.keyword, item_id, items_tables.table_name FROM keywords_items JOIN keywords ON keywords_items.keyword_id = keywords.id JOIN items_tables ON keywords_items.item_table_id = items_tables.id")  - use aliases (as) to avoid identical column names
    
    
    
    # binding.pry
    
    
    
    if item == nil
      redirect_to ("/whoops")      

    elsif item.class == Quote
      @item = item #==> object of attributes
     
      @keywords = @item.get_keywords
    
      render "quote"# , layout: "public"

    elsif item.class == Excerpt
      @item = item
      
      @keywords = @item.get_keywords
    
      render "excerpt", layout: "excerpt"

    elsif item.class == Person
      if item.state != ""
        item.state = "#{item.state}, "
      end
    
      @item = item
      
      @keywords = @item.get_keywords
    
      render "person"# , layout: "public"

    elsif item.class == Term
      @item = item 
      
      @keywords = @item.get_keywords
          
      render "term"# , layout: "public"
    end
  end

  def search
    @keywords = Keyword.select("keyword").to_a  
    @keywords.delete_if do |object|
      object.keyword == "quote" || object.keyword == "excerpt" || object.keyword == "term" || object.keyword == "person"
    end  
  end
  
  def keyword 
    @keyword = params["keyword"]
    @results = Keyword.find_by_keyword(@keyword).items_array
  end

  def item
    
    if params["table"] == "quotes"
      begin
        @item = Quote.find(params["id"])
        @keywords = @item.get_keywords
        render "quote"
      rescue
        redirect_to ("/whoops")
      end      
    
    elsif params["table"] == "excerpts"
      begin
        @item = Excerpt.find(params["id"])
        @keywords = @item.get_keywords
        render "excerpt", layout: "excerpt"
      rescue
        redirect_to ("/whoops")
      end      

    elsif params["table"] == "people"
      begin
        @item = Person.find(params["id"])
        
        if @item.state != ""
          @item.state = "#{@item.state}, "
        end
        
        @keywords = @item.get_keywords
        render "person"
      rescue
        redirect_to ("/whoops")
      end      

    elsif params["table"] == "terms"
      begin
        @item = Term.find(params["id"])
        @keywords = @item.get_keywords
        render "term"
      rescue
        redirect_to ("/whoops")
      end      
      
    else 
      redirect_to ("/whoops")

    end
  end
    
end

# class MyController < ApplicationController
#   layout :resolve_layout
#
#   # ...
#
#   private
#
#   def resolve_layout
#     case action_name
#     when "new", "create"
#       "some_layout"
#     when "index"
#       "other_layout"
#     else
#       "application"
#     end
#   end
# end