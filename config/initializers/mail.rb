Mail.defaults do
  retriever_method :pop3, {
    address: ENV['MAIL_POP3_ADDRESS'],
    port: ENV['MAIL_POP3_PORT'],
    user_name: ENV['MAIL_POP3_USER_NAME'],
    password: ENV['MAIL_POP3_PASSWORD'],
    enable_ssl: true
  }
end
