class User < ActiveRecord::Base
  has_secure_password #consistent interface to make passwords
  has_many :comments
end
#user(predefined).authenticate('password') to check if password is true or false
