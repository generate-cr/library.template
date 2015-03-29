module Generate
  module Library
    struct VersionView < View
      ecr_file "#{__DIR__}/../../../template/src/example/version.cr.ecr"

      def path
        "src/#{config.name}/version.cr"
      end
    end
  end
end
