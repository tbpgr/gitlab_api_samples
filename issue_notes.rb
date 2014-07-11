require 'gitlab'

Gitlab.configure do |config|
  config.endpoint       = 'http://some_path/api/v3' 
  config.private_token  = 'some token'
end
Gitlab.projects(per_page: 10).each do |project|
  Gitlab.issues(project.id, per_page: 10).each do |issue|
    issue_notes = Gitlab.issue_notes(project.id, issue.id)
    if issue_notes.size == 0
      puts "no issue notes"
    else
      puts issue_notes.first.body
    end
  end
end
