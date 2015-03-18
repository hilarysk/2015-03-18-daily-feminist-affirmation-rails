class User < ActiveRecord::Base
  include FeministInstanceMethods
  include BCrypt
    
  attr_accessible :user_name, :email, :password_hash, :privilege, :created_at 
    
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, :password, presence: true  
  
  has_many :terms
  has_many :excerpts
  has_many :people
  has_many :quotes
  
  #bcrypt method
    
  def password
    @password ||= Password.new(password_hash)
  end
  
  #bcrypt method

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
  
  # put user's contributions in descending order
  
  def items_array_sorted_descending
    array = []
    self.excerpts.each do |object|
      array.push object
    end
    self.quotes.each do |object|
      array.push object
    end
    self.terms.each do |object|
      array.push object
    end
    self.people.each do |object|
      array.push object
    end
    return array.sort! {|b,a| a.updated_at<=>b.updated_at}
  end
  
  # get array of items belonging to a user in order by type
  
  def items_array
    array = []
    self.excerpts.each do |object|
      array.push object
    end
    self.quotes.each do |object|
      array.push object
    end
    self.terms.each do |object|
      array.push object
    end
    self.people.each do |object|
      array.push object
    end
    return array
  end

  
end