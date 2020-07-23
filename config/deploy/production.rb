# EC2サーバーのIP、EC2サーバーにログインするユーザー名、サーバーのロールを記述
server '3.228.213.17', user: 'ec2-user', roles: %w{app db web}, ssh_options: {
    # capistranoコマンド実行者の秘密鍵
    keys: [File.expand_path('~/.ssh/myportfolio-ssh-key.pem')],
    forward_agent: true,
    auth_methods: %w(publickey)
}
