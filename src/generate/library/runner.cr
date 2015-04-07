require "generate/runner"

module Generate
  module Library
    class Runner < Generate::Runner
      def views
        [
         DirsView,
         LibsKeepView,
         SpecKeepView,
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
                                raw_config[:dir])
      end
    end

    class RunnerFactory < Generate::RunnerFactory
      getter raw_config

      def initialize
        @raw_config = {} of Symbol => String
      end

      def parse_opts(opts)
        initialize

        opts.on("--author AUTHOR_NAME",
                "Author name, example: 'John Smith', defaults to git configuration") do |author_name|
          raw_config[:author_name] = author_name
        end

        opts.on("--dir DIR", "Path to directory where library will be created, defaults to '.'") do |dir|
          raw_config[:dir] = dir
        end

        opts.unknown_args do |before_double_dash, rest|
          raw_config[:name] = before_double_dash[0]
        end
      end

      def build(raw_config)
        Runner.new(raw_config)
      end

      def default_config
        { :author_name => git_author_name,
          :dir => "." }
      end

      def git_author_name
        `git config --get user.name`.strip
      end
    end
  end

  Registry.add_runner("library", Library::RunnerFactory.new)
end
