# Watch all loaded env files with Spring
begin
  require 'spring/watcher'
  Denv.callback = -> (filename) do
    Spring.watch(filename) if Rails.application
  end
rescue LoadError
  # Spring is not available
end

module Denv
  class Railtie < ::Rails::Railtie
    DEFAULT_ENV_FILES = %w[.env.local .env.#{Rails.env} .env]

    config.before_configuration { load }

    def load
      DEFAULT_ENV_FILES.map {|name| root.join(name) }.select(&:exist?).each do |path|
        Denv.load(path)
      end
    end

    def root
      Rails.root || Pathname.new(ENV['RAILS_ROOT'] || Dir.pwd)
    end

    # Brought from dotenv.
    #
    # Rails uses `#method_missing` to delegate all class methods to the
    # instance, which means `Kernel#load` gets called here. We don't want that.
    def self.load
      instance.load
    end
  end
end
