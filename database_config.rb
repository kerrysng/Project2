require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'exercise_sharing',
  username: 'kerry'
}

ActiveRecord::Base.establish_connection( ENV['DATABASE_URL'] || options)
