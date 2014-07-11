require 'gitlab'

Gitlab.configure do |config|
  config.endpoint       = 'http://some_path/api/v3' 
  config.private_token  = 'your token'
end
puts Gitlab.users.size
Gitlab.create_user('hoge@hogehoge_hige.jp', 'sample_pass', username: 'hoge')
Gitlab.create_user('hige@hogehoge_hige.jp', 'sample_pass', username: 'hige')
puts Gitlab.users.size
