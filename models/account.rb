class Account < ActiveRecord::Base

  include BCrypt #bzzzz

  #setter for password_digest
  #define password = pwd (arg)
  def password=(pwd)
    #set the password_digest column
    #to BCrypt's Password.create method
    #using the user's input of 'pwd'
    self.password_digest = BCrypt::Password.create(pwd)
  end


end
