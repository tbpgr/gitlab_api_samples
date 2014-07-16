require 'gitlab'
require 'pp'

Gitlab.configure do |config|
  config.endpoint       = 'http://some_path/api/v3' 
  config.private_token  = 'some token'
end

Gitlab.projects(per_page: 100).each do |project|
  method_name = "create_#{project.name}_issue_note"
  # メソッドとして定義することで、コメントがあったかどうか判断して後から呼ぶ出すか呼び出さないか決める
  puts "def #{method_name}"
  project_id_code = "  projects = Gitlab.projects(per_page: 100).select { |e|e.name == '#{project.name}' }"
  puts project_id_code
  puts "  if projects.first"
  issue_notes_exist = false
  Gitlab.issues(project.id, per_page: 100).each do |issue|
    issue_id_code = "issues = Gitlab.issues(project_id, per_page: 100).select { |e|e.title == '#{issue.title}' }"
    issue_notes = Gitlab.issue_notes(project.id, issue.id)
    # issueにコメントがない場合は登録ロジックを出力しない
    next if issue_notes.size == 0
    issue_notes_exist = true
    # コメントを昇順にする
    issue_notes.sort_by { |e|e.created_at }
    puts "    project_id = projects.first.id"
    puts "    issues = #{issue_id_code}"
    puts "    if issues.first"
    issue_notes.each do |issue_note|
      puts "     issue_id = issues.first.id"
      body = issue_note.body.gsub("\r\n", '\\r\\n').gsub('"', '""')
      puts "      Gitlab.create_issue_note(project_id, issue_id, \"#{body}\")"
    end
    puts "    end"
  end
  puts "  end"
  puts "end"

  # コメントがあった場合のみメソッドを呼び出す
  puts method_name if issue_notes_exist
end
