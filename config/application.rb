require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

ROOM_FEATURES = YAML.load(File.read(File.expand_path('../room_features.yml', __FILE__)))

module Inspeckd
  class Application < Rails::Application

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: 'smtpout.secureserver.net',
      port: 465,
      domain: 'myinventoryllc.com',
      user_name: 'info@myinventoryllc.com',
      password: 'vossnorway',
      authentication: 'plain',
      enable_starttls_auto: true
    }
    
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
