class Person < ActiveRecord::Base
  include FeministInstanceMethods
  
  attr_accessible :person, :bio, :state, :country, :image, :caption, :source, :user_id, :created_at, :updated_at 

  has_many :excerpts
  has_many :quotes
  belongs_to :user

  has_many :keyword_items, as: :item
    
end