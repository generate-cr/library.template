module Generate
  module Library
    struct TravisView < View
      ecr_file "#{__DIR__}/../../../template/.travis.yml.ecr"

      def path
        ".travis.yml"
      end
    end
  end
end
