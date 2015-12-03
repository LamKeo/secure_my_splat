require 'bundler'
Bundler.require

#establishing connection to postgresql db
ActiveRecord::Base.establish_connection(
  :database => 'bee_crypt_bzz',
  :adapter => 'postgresql'
)

#basic template routes
get '/' do
  #return some resource
  return {:hello => 'world'}.to_json
end
