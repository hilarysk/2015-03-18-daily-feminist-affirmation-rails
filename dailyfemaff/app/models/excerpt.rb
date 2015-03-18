class Excerpt < ActiveRecord::Base
  include FeministInstanceMethods
  
  attr_accessible :excerpt, :source, :person_id, :user_id, :created_at, :updated_at
  
  belongs_to :person
  belongs_to :user
  
  has_many :keyword_items, as: :item

  validates :excerpt, uniqueness: { case_sensitive: false }
  validates :excerpt, :source, presence: true  
end