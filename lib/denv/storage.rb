module Denv
  module Storage
    class << self
      attr_writer :type

      def instance
        @instance ||= (@type || Base).new
      end

      def reset
        @type = @instance = nil
      end
    end

    class Base
      def get(name)
        raise "Set storage type: Denv::Storage.type = Denv::Storage::CredStash"
      end
    end

    class CredStash < Base
      def initialize
        @cache = {}
      end

      def get(name)
        str_name = name.to_s

        if @cache.has_key?(str_name)
          @cache[str_name]
        else
          @cache[str_name] = ::CredStash.get(name)
        end
      end
    end
  end
end
