class User < ActiveRecord::Base
    
  has_many   :posts
  has_many   :comments
  has_many   :likes
  
  validates :username, presence: true
  validates :password, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true  

end