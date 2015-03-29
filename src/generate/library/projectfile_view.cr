module Generate
  module Library
    struct ProjectfileView < View
      ecr_file "#{__DIR__}/../../../template/Projectfile.ecr"

      def path
        "Projectfile"
      end
    end
  end
end
