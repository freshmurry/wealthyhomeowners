Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local = true
  
   # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => 'public, max-age=172800'
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true
  
  config.action_controller.perform_caching = false
  
  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log
  
  # Send emails using letteropener in dev mode to open emails in a browser
  config.action_mailer.delivery_method = :letter_opener

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  config.assets.quiet = true
  
  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
  
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  config.action_cable.url = "ws://localhost:8080/cable"
  
  config.web_console.whitelisted_ips << "10.240.0.0/16"
  
  #Required for Heroku
  config.action_mailer.default_url_options = { host: 'https://9f143499177041dab60de7cf2ca34b9f.vfs.cloud9.us-east-1.amazonaws.com/' }
  
  #Mailgun Integration
  
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: 'smtp.mailgun.org',
    port: 587 ,
    domain: 'sandboxe2ffc76f2f4f40058be11a01d78ca90f.mailgun.org',
    authentication: 'plain',
    user_name: 'postmaster@sandboxe2ffc76f2f4f40058be11a01d78ca90f.mailgun.org',
    password: 'c38b467561efe05af2d7ee8a7213157b-52b6835e-a24c8b21'
  }
  
  # Gmail Integration
  
  # config.action_mailer.default_url_options = { host: 'localhost', port: 8080 }

  # config.action_mailer.delivery_method = :smtp
  # config.action_mailer.smtp_settings = {
  #   address: 'smtp.gmail.com',
  #   port: '587',
  #   enable_starttls_auto: true,
  #   authentication: 'plain',
  #   user_name: ENV['gmail_address'],
  #   password: ENV['gmail_password']
  # }
  
  # config.active_record.raise_in_transactional_callbacks = true
  
  # config.paperclip_defaults = {
  #   storage: :s3,
  #   path: ':class/:attachment/:id/:style/:filename',
  #   s3_host_name: 's3-ap-us-east-2.amazonaws.com',
  #   s3_credentials: {
  #     bucket: 'YOUR_S3_BUCKET_NAME',
  #     access_key_id: 'YOUR_S3_ACCESS_KEY',
  #     secret_access_key: 'YOUR_S3_SECRET_ACCESS_KEY',
  #     s3_region: 'ap-us-east-2'
  #   }
  # }
end