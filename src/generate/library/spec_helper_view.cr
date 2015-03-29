module Generate
  module Library
    struct SpecHelperView < View
      ecr_file "#{__DIR__}/../../../template/spec/spec_helper.cr.ecr"

      def path
        "spec/spec_helper.cr"
      end
    end
  end
end
