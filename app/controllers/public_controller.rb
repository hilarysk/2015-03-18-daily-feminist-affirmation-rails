class PublicController < ApplicationController
  
  def home
    render layout: "home"
  end
  
  def yay 
    item = (Quote.all + Term.all + Excerpt.all + Person.all).sample
  
    if item == nil
      redirect to ("/whoops")      

    elsif item.class == Quote
      @item = item #==> object of attributes
     
      if @item.keyword_items == [] #this if-check seems not to be working :((((((((((((((
        @keywords = ""
      else
        @keywords = @item.get_keywords
      end

      render "quote", layout: "public"

    elsif item.class == Excerpt
      @item = item
      
      if @item.keyword_items == []
        @keywords = ""
      else
        @keywords = @item.get_keywords
      end
    
      render "excerpt", layout: "excerpt"

    elsif item.class == Person
      if item.state != ""
        item.state = "#{item.state}, "
      end
    
      @item = item
      
      if @item.keyword_items == []
        @keywords = ""
      else
        @keywords = @item.get_keywords
      end
    
      render "person", layout: "public"

    elsif item.class == Term
      @item = item 
      
      if @item.keyword_items == []
        @keywords = ""
      else
        @keywords = @item.get_keywords
      end
          
      render "term", layout: "public"
    end
  end





  def whoops
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