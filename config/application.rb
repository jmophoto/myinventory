require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

ROOM_FEATURES = YAML.load(File.read(File.expand_path('../room_features.yml', __FILE__)))

module Inspeckd
  class Application < Rails::Application

    config.action_mailer.smtp_settings = {
      address: 'smtp.mailgun.org',
      port: 587,
      domain: 'sandbox233fbaecc8dc42e5b81062c9315beb83.mailgun.org',
      user_name: 'postmaster@sandbox233fbaecc8dc42e5b81062c9315beb83.mailgun.org',
      password: '4jvbqvijxhr3',
      authentication: :plain
    }
    config.action_mailer.delivery_method = :smtp
    
    #for bootstrap sass
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Mountain Time (US & Canada)'
    # config.active_record.default_timezone = :local
    
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
  end
end
