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

#getter for password
#define method to return password
  def password
    BCrypt::Password.new(self.password_digest)
  end

  #create a method to test if we are allowed authorization
  #so we need to authenticate
  #we log in with a user_name and password..
  #this method handles all that on the backend
  #Usage: Account.authenticate('james', 'hello123')
  #Usage: Account.authenticate(params[:username], params[:password])
  def self.authenticate(user_name, password)
    #search for user
    #Account model.find_by column name with value to search
    current_user = Account.find_by(user_name: user_name)
    #return our current user IF passwords match
    if (current_user.password == password)
      return current_user
    else
      return nil
    end
  end


end
