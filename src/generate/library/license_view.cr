module Generate
  module Library
    struct LicenseView < View
      ecr_file "#{__DIR__}/../../../template/LICENSE.ecr"

      def path
        "LICENSE"
      end
    end
  end
end
