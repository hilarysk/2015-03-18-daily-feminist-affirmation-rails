class Quote < ActiveRecord::Base
  include FeministInstanceMethods
  
  attr_accessible :quote, :person_id, :user_id, :created_at, :updated_at
  
  belongs_to :person
  belongs_to :user
  
  has_many :keyword_items, as: :item

  
end