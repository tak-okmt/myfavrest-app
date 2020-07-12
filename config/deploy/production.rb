# EC2サーバーのIP、EC2サーバーにログインするユーザー名、サーバーのロールを記述
server '54.237.173.243', user: 'osaka', roles: %w{app db web} 

#デプロイするサーバーにsshログインする鍵の情報を記述
set :ssh_options, {
  keys: %w(~/.ssh/authorized_keys),
  forward_agent: true,
  auth_methods: %w(publickey)
}
