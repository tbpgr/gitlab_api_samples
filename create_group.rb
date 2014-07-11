require 'gitlab'

Gitlab.configure do |config|
  config.endpoint       = 'http://some_path/api/v3' 
  config.private_token  = 'some token'
end
puts Gitlab.groups.size

Gitlab.create_group('SampleGroup1', 'sample_group1')
Gitlab.create_group('SampleGroup2', 'sample_group2')

puts Gitlab.groups.size