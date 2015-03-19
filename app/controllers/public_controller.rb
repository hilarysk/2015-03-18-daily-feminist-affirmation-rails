class PublicController < ApplicationController
  
  def home
    render layout: "home"
  end
  
  def yay 
    item = (Quote.all + Term.all + Excerpt.all + Person.all).sample
      
    if item == nil
      redirect_to ("/whoops")      

    elsif item.class == Quote
      @item = item #==> object of attributes
     
      @keywords = @item.get_keywords
    
      render "quote", layout: "public"

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
    
      render "person", layout: "public"

    elsif item.class == Term
      @item = item 
      
      @keywords = @item.get_keywords
          
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