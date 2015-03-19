# Module: FeministInstanceMethods
#
# Toolbox for use in the Daily Feminist Affirmation program; contains instance methods that could work for multiple classes.
#
# Public Methods:
# #search_table_by_value
# #save


module FeministInstanceMethods
  
  def get_keywords
    array = []
    
    if self.keyword_items[0] == nil
      return ""
    
    else
      self.keyword_items.each do |object|
        array.push object.keyword.keyword 
      end
    end
    
    return array
  end
  
  
  def check_for_no_method_error(method)
    self.respond_to?(:method) ? self.method : nil
  end

end