require 'gitlab'

Gitlab.configure do |config|
  config.endpoint       = 'http://some_path/api/v3' 
  config.private_token  = 'some tokne'
end
groups =  Gitlab.groups

puts groups.first.id
puts groups.first.name
puts groups.first.path
puts groups.first.owner_id

groups.each do |group|
  puts "Gitlab.create_group('#{group.name}', '#{group.path}')"
end
