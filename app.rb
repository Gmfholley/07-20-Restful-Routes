require "rubygems"
require "bundler/setup"

require "pry"
require "active_record"
require "sinatra"
require "sinatra/reloader"
require "bcrypt"

configure :development do
  require 'sqlite3'
  ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'stories.db')
end

## Sinatra specific 
configure :production do
  require 'pg'
  db = URI.parse(ENV['DATABASE_URL'])

  ActiveRecord::Base.establish_connection(
    :adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host     => db.host,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'utf8'
  )
end

# So that ActiveRecord explains the SQL it's running in the logs.
ActiveRecord::Base.logger = ActiveSupport::Logger.new(STDOUT)

unless ActiveRecord::Base.connection.table_exists?(:users)
  ActiveRecord::Base.connection.create_table :users do |t|
    t.text :email
    t.text :password
  end  
end

unless ActiveRecord::Base.connection.table_exists?(:stories)
  ActiveRecord::Base.connection.create_table :stories do |t|
    t.text :name
    t.integer :user_id
  end  
end

require_relative 'models/user.rb'
require_relative 'models/story.rb'


require_relative 'controllers/login_helper.rb'
require_relative 'controllers/users_controller.rb'
require_relative 'controllers/stories_controller.rb'

set :sessions, true
helpers LoginHelper
