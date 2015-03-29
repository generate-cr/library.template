module Generate
  module Library
    struct Config
      property name
      property author_name
      property logger
      property dir

      def initialize(@name, @author_name, @logger, @dir = ".")
      end

      def module_name
        name.camelcase
      end
    end
  end
end
