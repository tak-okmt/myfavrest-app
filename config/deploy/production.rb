# EC2サーバーのIP、EC2サーバーにログインするユーザー名、サーバーのロールを記述
server '54.243.217.170', user: 'ec2-user', roles: %w[app db web], ssh_options: {
  # capistranoコマンド実行者の秘密鍵
  keys: %w[~/.ssh/myportfolio-ssh-key1.pem],
  forward_agent: true,
  auth_methods: %w[publickey]
}
set :stage, :production
