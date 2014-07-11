require 'gitlab'

def show_issue_detail(issue, message_header = '')
  assignee_id = issue.assignee ? issue.assignee.id : ''
  puts message_header
  puts issue.id
  puts issue.iid
  puts issue.project_id
  puts issue.title
  puts issue.description
  puts assignee_id
  puts issue.state
  puts issue.labels
end

Gitlab.configure do |config|
  config.endpoint       = 'http://some_path/api/v3' 
  config.private_token  = 'some token'
end
project_id = 31
Gitlab.create_issue(project_id, 'new_title', description: 'new_description', assignee_id: 1, labels: 'ruby,gitlab')
new_issue = Gitlab.issues(project_id).first
show_issue_detail(new_issue, "-------new record-------")
Gitlab.edit_issue(project_id, new_issue.id, title:'edit_title', description: 'edit_description', assignee_id: 4, state_event: 'close', labels: 'perl,github')
edit_issue = Gitlab.issue(project_id, new_issue.id)
show_issue_detail(edit_issue, "-------edit record-------")
