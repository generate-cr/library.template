module Generate
  module Library
    struct ReadmeView < View
      ecr_file "#{__DIR__}/../../../template/README.md.ecr"

      def path
        "README.md"
      end
    end
  end
end
