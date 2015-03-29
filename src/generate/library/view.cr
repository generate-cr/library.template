module Generate
  module Library
    struct View
      property config

      def initialize(@config)
      end

      def render
        config.logger.info("File #{full_path}")
        File.write(full_path, to_s)
      end

      def path
        fail "Abstract method #path"
      end

      def to_s(io)
        fail "Abstract method #to_s"
      end

      private def full_path
        "#{config.dir}/#{config.name}/#{path}"
      end
    end
  end
end
