# Site Admin

> Back end for personal site administration

---

## Application Setup Instructions

> This is a helpful cheat sheet for setting up and configuring a rails app

---

- rails new {application-name-here} --skip-test-unit
- update Gemfile

```

    source 'https://rubygems.org'
    ruby '2.0.0'
    #ruby-gemset=railstutorial_rails_4_0

    gem 'rails', '4.0.0'
    gem 'bootstrap-sass', '2.3.2.0'
    gem 'bcrypt-ruby', '3.0.1'
    gem 'faker', '1.1.2'
    gem 'will_paginate', '3.0.4'
    gem 'bootstrap-will_paginate', '0.0.9'
    gem 'modernizr-rails', '2.6.2.3'
    gem 'devise', '3.2.4'

    group :development, :test do
      gem 'sqlite3', '1.3.8'
      gem 'rspec-rails', '2.13.1'
    end

    group :test do
      gem 'selenium-webdriver', '2.35.1'
      gem 'capybara', '2.1.0'
      gem 'factory_girl_rails', '4.2.1'
      gem 'debugger', '1.6.2'
    end

    gem 'sass-rails', '4.0.1'
    gem 'uglifier', '2.1.1'
    gem 'coffee-rails', '4.0.1'
    gem 'jquery-rails', '3.0.4'
    gem 'turbolinks', '1.1.1'
    gem 'jbuilder', '1.0.2'

    group :doc do
      gem 'sdoc', '0.3.20', require: false
    end

    group :production do
      gem 'pg', '0.15.1'
      gem 'rails_12factor', '0.0.2'
    end

```

- bundle install --without production
- bundle update
- bundle install
- update config/initializers/secret_token.rb (add app name -> {application-name-here})

```

    # Be sure to restart your server when you modify this file.

    # Your secret key is used for verifying the integrity of signed cookies.
    # If you change this key, all old signed cookies will become invalid!

    # Make sure the secret is at least 30 characters and all random,
    # no regular words or you'll be exposed to dictionary attacks.
    # You can use `rake secret` to generate a secure secret key.

    # Make sure your secret_key_base is kept private
    # if you're sharing your code publicly.
    require 'securerandom'

    def secure_token
      token_file = Rails.root.join('.secret')
      if File.exist?(token_file)
        # Use the existing token.
        File.read(token_file).chomp
      else
        # Generate a new token and store it in token_file.
        token = SecureRandom.hex(64)
        File.write(token_file, token)
        token
      end
    end

    {application-name-here}::Application.config.secret_key_base = secure_token

```

- rails generate rspec:install
- Add Capybara DSL to the end of (before closing end tag) spec/spec_helper.rb

```

    # This file is copied to spec/ when you run 'rails generate rspec:install'
    ENV["RAILS_ENV"] ||= 'test'
    require File.expand_path("../../config/environment", __FILE__)
    require 'rspec/rails'
    require 'rspec/autorun'

    # Requires supporting ruby files with custom matchers and macros, etc,
    # in spec/support/ and its subdirectories.
    Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

    # Checks for pending migrations before tests are run.
    # If you are not using ActiveRecord, you can remove this line.
    ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

    RSpec.configure do |config|
      # ## Mock Framework
      #
      # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
      #
      # config.mock_with :mocha
      # config.mock_with :flexmock
      # config.mock_with :rr

      # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
      config.fixture_path = "#{::Rails.root}/spec/fixtures"

      # If you're not using ActiveRecord, or you'd prefer not to run each of your
      # examples within a transaction, remove the following line or assign false
      # instead of true.
      config.use_transactional_fixtures = true

      # If true, the base class of anonymous controllers will be inferred
      # automatically. This will be the default behavior in future versions of
      # rspec-rails.
      config.infer_base_class_for_anonymous_controllers = false

      # Run specs in random order to surface order dependencies. If you find an
      # order dependency and want to debug it, you can fix the order by providing
      # the seed, which is printed after each run.
      #     --seed 1234
      config.order = "random"
      config.include Capybara::DSL
    end

```

- add config.assets.precompile to config/application.rb

```

    require File.expand_path('../boot', __FILE__)

    # Pick the frameworks you want:
    require "active_record/railtie"
    require "action_controller/railtie"
    require "action_mailer/railtie"
    require "sprockets/railtie"
    # require "rails/test_unit/railtie"

    # Require the gems listed in Gemfile, including any gems
    # you've limited to :test, :development, or :production.
    Bundler.require(:default, Rails.env)

    module {application-name-here}
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
        config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)
      end
    end

```

- uncomment config.force_ssl in config/environments/production.rb

```

    {application-name-here}::Application.configure do
      # Settings specified here will take precedence over those in config/application.rb.

      # Code is not reloaded between requests.
      config.cache_classes = true

      # Eager load code on boot. This eager loads most of Rails and
      # your application in memory, allowing both thread web servers
      # and those relying on copy on write to perform better.
      # Rake tasks automatically ignore this option for performance.
      config.eager_load = true

      # Full error reports are disabled and caching is turned on.
      config.consider_all_requests_local       = false
      config.action_controller.perform_caching = true

      # Enable Rack::Cache to put a simple HTTP cache in front of your application
      # Add `rack-cache` to your Gemfile before enabling this.
      # For large-scale production use, consider using a caching reverse proxy like nginx, varnish or squid.
      # config.action_dispatch.rack_cache = true

      # Disable Rails's static asset server (Apache or nginx will already do this).
      config.serve_static_assets = false

      # Compress JavaScripts and CSS.
      config.assets.js_compressor = :uglifier
      # config.assets.css_compressor = :sass

      # Do not fallback to assets pipeline if a precompiled asset is missed.
      config.assets.compile = false

      # Generate digests for assets URLs.
      config.assets.digest = true

      # Version of your assets, change this if you want to expire all your assets.
      config.assets.version = '1.0'

      # Specifies the header that your server uses for sending files.
      # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
      # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

      # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
      config.force_ssl = true

      # Set to :debug to see everything in the log.
      config.log_level = :info

      # Prepend all log lines with the following tags.
      # config.log_tags = [ :subdomain, :uuid ]

      # Use a different logger for distributed setups.
      # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

      # Use a different cache store in production.
      # config.cache_store = :mem_cache_store

      # Enable serving of images, stylesheets, and JavaScripts from an asset server.
      # config.action_controller.asset_host = "http://assets.example.com"

      # Precompile additional assets.
      # application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
      # config.assets.precompile += %w( search.js )

      # Ignore bad email addresses and do not raise email delivery errors.
      # Set this to true and configure the email server for immediate delivery to raise delivery errors.
      # config.action_mailer.raise_delivery_errors = false

      # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
      # the I18n.default_locale when a translation can not be found).
      config.i18n.fallbacks = true

      # Send deprecation notices to registered listeners.
      config.active_support.deprecation = :notify

      # Disable automatic flushing of the log to improve performance.
      # config.autoflush_log = false

      # Use default logging formatter so that PID and timestamp are not suppressed.
      config.log_formatter = ::Logger::Formatter.new
    end

```

- git init
- git add .
- git mv README.rdoc README.md
- Modify README.md as needed
- update .gitignore

```

    # Ignore bundler config.
    /.bundle

    # Ignore the default SQLite database.
    /db/*.sqlite3
    /db/*.sqlite3-journal

    # Ignore all logfiles and tempfiles.
    /log/*.log
    /tmp

    # Ignore other unneeded files.
    database.yml
    doc/
    *.swp
    *~
    .project
    .DS_Store
    .idea
    .secret

```