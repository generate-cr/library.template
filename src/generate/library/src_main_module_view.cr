module Generate
  module Library
    struct SrcMainModuleView < View
      ecr_file "#{__DIR__}/../../../template/src/example.cr.ecr"

      def path
        "src/#{config.name}.cr"
      end
    end
  end
end
