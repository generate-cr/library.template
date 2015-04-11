require "generate/view"

module Generate
  module Library
    struct View < Generate::FileView
      def full_path
        "#{config.dir}/#{config.name}/#{path}"
      end
    end

    struct DirsView < Generate::View
      def render_with_log
        ["libs", "src/#{config.name}", "spec/#{config.name}"].each do |path|
          full_path = "#{config.dir}/#{config.name}/#{path}"
          logger.info("Directory #{full_path}")
          Dir.mkdir_p(full_path)
        end
      end
    end

    generate_template LibsKeepView, View, "library.template", ".keep.ecr", "libs/.keep"
    generate_template SpecKeepView, View, "library.template", ".keep.ecr", "spec/#{config.name}/.keep"

    generate_template LicenseView, View, "library.template", "LICENSE.ecr", "LICENSE"
    generate_template GitignoreView, View, "library.template", ".gitignore.ecr", ".gitignore"
    generate_template ProjectfileView, View, "library.template", "Projectfile.ecr", "Projectfile"
    generate_template ReadmeView, View, "library.template", "README.md.ecr", "README.md"
    generate_template TravisView, View, "library.template", ".travis.yml.ecr", ".travis.yml"

    generate_template SrcMainModuleView, View, "library.template", "src/example.cr.ecr", "src/#{config.name}.cr"
    generate_template VersionView, View, "library.template", "src/example/version.cr.ecr", "src/#{config.name}/version.cr"

    generate_template SpecHelperView, View, "library.template", "spec/spec_helper.cr.ecr", "spec/spec_helper.cr"
    generate_template SpecMainModuleView, View, "library.template", "spec/example_spec.cr.ecr", "spec/#{config.name}_spec.cr"
  end
end
