module Generate
  module Library
    struct Config
      property name
      property author_name
      property dir

      def initialize(@name, @author_name, @dir = ".")
      end

      def module_name
        name.camelcase
      end
    end
  end
end
