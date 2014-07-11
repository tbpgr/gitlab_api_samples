require 'gitlab'

Gitlab.configure do |config|
  config.endpoint       = 'http://some_ip/api/v3' 
  config.private_token  = 'some token'
end
projects =  Gitlab.projects

projects.each do |project|
  wiki_git_repo = project.ssh_url_to_repo.gsub(/\.git/, '.wiki.git')
  puts "git clone #{wiki_git_repo}"
end
