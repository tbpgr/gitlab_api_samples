require 'gitlab'

Gitlab.configure do |config|
  config.endpoint       = 'http://some_path/api/v3' 
  config.private_token  = 'some token'
end
puts Gitlab.issues.size
project_id = 31
issue_title = 'api test2'
options = {
  description: 'description',
  assignee_id: 4,
  labels: 'ruby,gitlab',
}
Gitlab.create_issue(project_id, issue_title, options)
puts Gitlab.issues.size