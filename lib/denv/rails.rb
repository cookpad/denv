# Watch all loaded env files with Spring
begin
  require 'spring/watcher'

  if Spring.respond_to?(:watch)
    Denv.callback = -> (filename) do
      Spring.watch(filename) if Rails.application
    end
  end
rescue LoadError
  # Spring is not available
end

module Denv
  class Railtie < ::Rails::Railtie
    DEFAULT_ENV_FILES = %w[.env.local .env.#{Rails.env} .env]

    config.before_configuration { load_env }

    def load_env
      DEFAULT_ENV_FILES.map {|name| root.join(name) }.select(&:exist?).each do |path|
        Denv.load(path)
      end
    end

    def root
      Rails.root || Pathname.new(ENV['RAILS_ROOT'] || Dir.pwd)
    end
  end
end
