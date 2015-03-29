module Generate
  module Library
    struct Runner
      property config

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

      def initialize(@config)
      end

      def run
        views.each do |view|
          view.new(config).render
        end
        true
      end
    end
  end
end
