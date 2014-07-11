require 'gitlab'

Gitlab.configure do |config|
  config.endpoint       = 'http://some_path/api/v3' 
  config.private_token  = 'some token'
end

puts Gitlab.projects.size
Gitlab.create_project('some project', description: 'some project desc', public: 'false', namespace_id: Gitlab.groups.find { |g|g.name == 'some_group_name' }.id)
puts Gitlab.projects.size
