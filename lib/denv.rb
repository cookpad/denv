require "denv/version"

module Denv
  class Error < StandardError
  end

  class NoSuchFileError < Error
    def initialize(filename)
      super("Can not find envfile: #{filename}")
    end
  end

  class InvalidFormatError < Error
    def initialize(line, filename, lineno)
      super("key and value must be separated by `=`: #{filename}:#{lineno}: #{line}")
    end
  end

  class InvalidKeyNameError < Error
    def initialize(line, filename, lineno)
      super("key can not contain whitespaces: #{filename}:#{lineno}: #{line}")
    end
  end

  class << self
    DEFAULT_ENV_FILENAME = '.env'.freeze

    attr_accessor :callback

    # Read from .env file and load vars into `ENV`.
    # Default is over-write.
    # @param [String] filename
    # @return [Hash] env
    def load(filename = DEFAULT_ENV_FILENAME)
      filename = File.expand_path(filename.to_s)
      run_callback(filename) do
        build_env(filename).each {|k, v| ENV[k] = v }
      end
    end

    # Read from .env file and build env Hash.
    # @param [String] filename
    # @return [Hash] loaded environment variables
    def build_env(filename)
      open_file(filename) {|f| Parser.new(f, filename).parse }
    end

    private

    def open_file(filename)
      File.open(filename) {|f| yield f }
    rescue Errno::ENOENT
      raise NoSuchFileError.new(filename)
    end

    def run_callback(filename)
      callback.call(filename) if callback
      yield
    end
  end

  class Parser
    COMMENT_CHAR = '#'
    DELIMITER = '='
    WHITE_SPACES = /\s/

    def initialize(io, filename)
      @io = io
      @filename = filename
    end

    def parse
      env = {}

      @io.each_line.with_index do |line, i|
        line = line.chomp.lstrip
        if !line.empty? && !line.start_with?(COMMENT_CHAR)
          key, value = line.split(DELIMITER, 2)
          if key && value
            if key.match(WHITE_SPACES)
              raise InvalidKeyNameError.new(line, @filename, i + 1)
            else
              env[key] = value
            end
          else
            raise InvalidFormatError.new(line, @filename, i + 1)
          end
        end
      end

      env
    end
  end
end

require 'denv/rails' if defined?(Rails)
