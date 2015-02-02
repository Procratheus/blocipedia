if Rails.env.development?
  Actionmailer::Base.delivery_method = :smtp
  Actionmailer::Base.smtp_settings = {
    address:         "smtp.send.net",
    port:            "587",
    authentication:  :plain,
    user_name:       ENV["SENDGRID_USERNAME"],
    password:        ENV["SENDGRID_PASSWORD"],
    domain:          "heroku.com",
    enable_starttls_auto: true
  }
end