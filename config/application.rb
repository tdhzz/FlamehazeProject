require_relative 'boot'

require 'rails/all'
require_relative '../lib/util'
require_relative 'return_code/error_code'
require_relative 'return_code/common_exception'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

ENV['ALIPAY_PID'] = 'YOUR-ALIPAY-PARTNER-ID'
ENV['ALIPAY_MD5_SECRET'] = 'YOUR-ALIPAY-MD5-SECRET'
ENV['ALIPAY_URL'] = 'https://mapi.alipay.com/gateway.do'
ENV['ALIPAY_RETURN_URL'] = 'http://localhost:3000/payments/pay_return'
ENV['ALIPAY_NOTIFY_URL'] = 'http://localhost:3000/payments/pay_notify'


module FlamehazeRws
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.autoload_paths += %W[#{Rails.root}/lib]

    config.generators do |generator|
      generator.assets false
      generator.test_framework false
      generator.skip_routes true
    end

    config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir[Rails.root.join('app', 'api', '*')]
  end
end
