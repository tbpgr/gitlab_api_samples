require 'gitlab'

Gitlab.configure do |config|
  config.endpoint       = 'http://some_ipo/api/v3' 
  config.private_token  = 'some token'
end
projects =  Gitlab.projects per_page: 1

puts projects.first.ssh_url_to_repo
puts projects.first.http_url_to_repo
puts projects.first.web_url
