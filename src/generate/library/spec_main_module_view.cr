module Generate
  module Library
    struct SpecMainModuleView < View
      ecr_file "#{__DIR__}/../../../template/spec/example_spec.cr.ecr"

      def path
        "spec/#{config.name}_spec.cr"
      end
    end
  end
end
