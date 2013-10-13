Mail.defaults do
  delivery_method :smtp, { :address   => "smtp.sendgrid.net",
                           :port      => 587,
                           :domain    => "techscour.com",
                           :user_name => ENV['MGNAME'],
                           :password  => ENV['MGPASS'],
                           :authentication => 'plain',
                           :enable_starttls_auto => true }
end