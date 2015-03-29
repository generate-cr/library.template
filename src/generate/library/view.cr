module Generate
  module Library
    struct View
      property config

      def initialize(@config)
      end

      def render
        File.write("#{config.dir}/#{config.name}/#{path}", to_s)
      end

      def path
        fail "Abstract method #path"
      end

      def to_s(io)
        fail "Abstract method #to_s"
      end
    end
  end
end
