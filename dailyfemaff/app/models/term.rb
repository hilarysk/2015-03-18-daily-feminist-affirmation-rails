class Term < ActiveRecord::Base
  include FeministInstanceMethods
  
  attr_accessible :term, :definition, :phonetic, :user_id, :created_at, :updated_at
  
  belongs_to :user
  
  has_many :keyword_items, as: :item  
      
end