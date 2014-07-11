require 'gitlab'

Gitlab.configure do |config|
  config.endpoint       = 'http://some_path/api/v3' 
  config.private_token  = 'some token'
end
users =  Gitlab.users

puts users.first.id
puts users.first.username
puts users.first.state
puts users.first.is_admin
puts users.first.email
puts users.first.can_create_project
