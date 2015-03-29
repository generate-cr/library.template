module Generate
  module Library
    struct KeepView < View
      def render
        ["libs", "spec/#{config.name}"].each do |path|
          File.write("#{config.dir}/#{config.name}/#{path}/.keep", "")
        end
      end
    end
  end
end
