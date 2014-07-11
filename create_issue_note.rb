require 'gitlab'

Gitlab.configure do |config|
  config.endpoint       = 'http://some_path/api/v3' 
  config.private_token  = 'some token'
end
project_id = 31
issue_id = 102
body = '*sample comment* :smile:'
puts Gitlab.issue_notes(project_id, issue_id).size

Gitlab.create_issue_note(project_id, issue_id, body)

puts Gitlab.issue_notes(project_id, issue_id).size
