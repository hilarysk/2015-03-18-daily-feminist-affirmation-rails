
# Class: Composite
#
# Used for multi-table database calls
#
# Attributes:
#
# Public Methods:
# #insert
# #self.array_of_excerpt_records
# 
# Private Methods:
# #initialize

class Composite < ActiveRecord::Base
  include FeministInstanceMethods
  
  has_many :people, :quotes, :terms, :excerpts
  
  def main_page_item_sampler
    self.find_by_sql("SELECT people.*, terms.*, quotes.*, excerpts.* FROM people, terms, quotes, excerpts")
  end

end


