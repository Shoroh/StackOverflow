require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module StackOverflow
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: true,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       request_specs: false,
                       controller_specs: true
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end

    # Tag's configs
    ActsAsTaggableOn.force_lowercase = true
    ActsAsTaggableOn.delimiter = ','

    config.quiet_assets = true

    config.active_record.observers = :karma_observer

    CarrierWave.configure do |config|
      config.storage    = :aws
      config.aws_bucket = ENV['AWS_BUCKET']
      config.aws_acl    = :public_read
      config.asset_host = 'http://s3-ap-southeast-1.amazonaws.com/bankomatchik'
      config.aws_authenticated_url_expiration = 60 * 60 * 24 * 365

      config.aws_credentials = {
          access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
          secret_access_key: ENV['AWS_ACCESS_KEY']
      }
    end
    config.autoload_paths << Rails.root.join('lib/middleware')
    config.middleware.insert_after Rack::Runtime, 'DailyRateLimit' unless Rails.env.test?
  end
end
