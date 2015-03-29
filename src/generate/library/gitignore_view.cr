module Generate
  module Library
    struct GitignoreView < View
      ecr_file "#{__DIR__}/../../../template/.gitignore.ecr"

      def path
        ".gitignore"
      end
    end
  end
end
