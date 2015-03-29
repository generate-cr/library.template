require "./view"

module Generate
  module Library
    struct DirsView < View
      def render
        ["libs", "src/#{config.name}", "spec/#{config.name}"].each do |path|
          full_path = "#{config.dir}/#{config.name}/#{path}"
          config.logger.info("Directory #{full_path}")
          Dir.mkdir_p(full_path)
        end
      end
    end
  end
end
