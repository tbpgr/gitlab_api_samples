require 'gitlab'

Gitlab.configure do |config|
  config.endpoint       = 'http://some_path/api/v3' 
  config.private_token  = 'some token'
end
issues =  Gitlab.issues
# issues =  Gitlab.issues 0
# issues =  Gitlab.issues 5
# issues =  Gitlab.issues 5, per_page: 100
# issues =  Gitlab.issues 0, per_page: 100
# issues =  Gitlab.issues 0, page: 2, per_page: 10 

issue = issues[0]
puts "id = #{issue.id}"
puts "project_id = #{issue.project_id}"
puts "title = #{issue.title}"
puts "description = #{issue.description}"
puts "state = #{issue.state}"
puts "assignee.id = #{issue.assignee.id}"
puts "author.id = #{issue.author.id}"
