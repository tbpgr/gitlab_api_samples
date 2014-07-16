require 'gitlab'
require 'pp'

Gitlab.configure do |config|
  config.endpoint       = 'http://some_path/api/v3' 
  config.private_token  = 'some token'
end

def find_project_id_from_project_name(name)
  Gitlab.projects(per_page: 100).select { |e|e.name == name }.first.id
end

project_id = find_project_id_from_project_name('project_name')
Gitlab.issues(project_id).each do |issue|
  Gitlab.edit_issue(project_id, issue.id, title: 'delete', state_event: 'close')
end
