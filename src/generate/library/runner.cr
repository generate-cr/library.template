require "generate/runner"

module Generate
  module Library
    struct Runner < Generate::Runner
      def views
        [
         DirsView,
         KeepView,
         GitignoreView,
         TravisView,
         LicenseView,
         ProjectfileView,
         ReadmeView,
         SrcMainModuleView,
         VersionView,
         SpecHelperView,
         SpecMainModuleView,
        ]
      end

      def config
        @_config ||= Config.new(raw_config[:name],
                                raw_config[:author_name],
                                logger,
                                raw_config[:dir])
      end
    end
  end
end
