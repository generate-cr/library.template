require "./view"

module Generate
  module Library
    struct DirsView < View
      def render
        ["libs", "src/#{config.name}", "spec/#{config.name}"].each do |path|
          Dir.mkdir_p("#{config.dir}/#{config.name}/#{path}")
        end
      end
    end
  end
end
