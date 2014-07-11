require 'gitlab'

Gitlab.configure do |config|
  config.endpoint       = 'http://from_server_path/api/v3' 
  config.private_token  = 'from server token'
end

module Gitlab
  class ObjectifiedHash
    def create_issue_code(project_name, title)
      options = options_code
      "Gitlab.create_issue(Gitlab.projects(per_page: 100).select { |e|e.name == '#{project_name}' }.first.id, '#{title}'#{options})"
    end

    def options_code
      options = %w{description state assignee_id labels}
      codes = options.each_with_object([]) do |option, memo|
        option_code = send("#{option}_option")
        next if option_code.empty?
        memo << option_code
      end
      codes.size == 0 ? '' : ", #{codes.join(', ')}"
    end

    def description_option
      return '' unless description
      "description: \"#{description}\""
    end

    def assignee_id_option
      return '' unless assignee
      "assignee_id: Gitlab.users.select { |e|e.name == '#{assignee.name}' }.first.id"
    end

    def labels_option
      return '' if labels.size == 0
      "labels:'#{labels.join(',')}'"
    end
  end
end

projects = Gitlab.projects(per_page: 100)
projects.each do |project|
  project_name = project.name
  issues =  Gitlab.issues(project.id, per_page: 100)
  issues.each do |issue|
    puts issue.create_issue_code(project_name, issue.title)
  end
end
