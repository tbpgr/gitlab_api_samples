require 'gitlab'
require 'pp'

Gitlab.configure do |config|
  config.endpoint       = 'http://some_path/api/v3' 
  config.private_token  = 'some token'
end

def find_project_id_from_project_name(name)
  Gitlab.projects(per_page: 100).select { |e|e.name == name }.first.id
end

def copy_issues(from_project_id, to_project_id)
  Gitlab.issues(from_project_id, per_page: 100).each do |issue|
    assignee_id = issue.assignee ? issue.assignee.id : nil
    milestone_id  = issue.milestone_id  ? issue.milestone_id.id : nil
    Gitlab.create_issue(to_project_id, issue.title,
      description: issue.description,
      assignee_id: assignee_id,
      milestone_id: milestone_id,
      labels: issue.labels)

    # closeされたIssueの場合はステータスをclosedに変更する
    to_issue = Gitlab.issues(to_project_id, per_page: 100).select { |e|e.title == issue.title }.first
    if to_issue && issue.state == 'closed'
      Gitlab.edit_issue(to_project_id, to_issue.id, state_event: 'close')
    end
  end
end

from_project_id = find_project_id_from_project_name('from_project')
to_project_id = find_project_id_from_project_name('to_project')
copy_issues(from_project_id, to_project_id)
