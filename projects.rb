require 'gitlab'

Gitlab.configure do |config|
  config.endpoint       = 'http://some_path/api/v3' 
  config.private_token  = 'some token'
end
projects =  Gitlab.projects

puts projects.first.id
puts projects.first.name
puts projects.first.description
puts projects.first.public
