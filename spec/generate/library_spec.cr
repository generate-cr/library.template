require "../spec_helper"

DIFFERENT_AUTHOR = { :author => "Mary Johnson" }
DIFFERENT_NAME = { :name => "another_example" }

module Generate
  describe_file Library do
    describe_file "example/.gitignore" do |gitignore|
      gitignore.should be_including(".deps/")
      gitignore.should be_including(".crystal/")
      gitignore.should be_including(".deps.lock")
    end

    describe_file "example/.travis.yml" do |travis|
      parsed = YAML.load(travis.contents) as Hash

      parsed["language"].should eq("c")
      parsed["before_install"].should be_including("curl http://dist.crystal-lang.org/apt/setup.sh | sudo bash")
      parsed["before_install"].should be_including("sudo apt-get -q update")
      parsed["install"].should be_including("sudo apt-get install crystal")
      parsed["script"].should eq(["crystal spec"])
    end

    describe_file "example/LICENSE" do |license|
      # TODO: Create a library along the lines of ruby timecop and use it here to mock year
      year = Time.now.year
      license.should be_including("Copyright (c) #{year} John Smith")
    end

    describe_file "example/LICENSE", { :re_run => "true" } do |license|
      # TODO: Create a library along the lines of ruby timecop and use it here to mock year
      year = Time.now.year

      Timecop.freeze(3.years.from_now) do
        license.should be_including("Copyright (c) #{year + 3} John Smith")
      end
    end

    describe_file "example/Projectfile" do |projectfile|
      projectfile.should eq(%{deps do\nend})
    end

    describe_file "example/README.md" do |readme|
      readme.should be_including("# example")

      readme.should be_including(%{```crystal
deps do
  github "[your-github-name]/example"
end
```})

      readme.should be_including(%{require "example"})

      readme.should be_including(%{1. Fork it ( https://github.com/[your-github-name]/example/fork )})

      readme.should be_including(%{[your-github-name](https://github.com/[your-github-name]) John Smith - creator})
    end

    describe_file "example/libs/.keep" do |libs_keep|
      libs_keep.should eq("")
    end

    describe_file "example/spec/example/.keep" do |libs_keep|
      libs_keep.should eq("")
    end

    describe_file "example/src/example.cr" do |example|
      example.should eq(%{require "./example/*"

module Example
  # TODO Put your code here
end
})
    end

    describe_file "example/src/example/version.cr" do |version|
      version.should eq(%{module Example
  VERSION = "0.0.1"
end
})
    end

    describe_file "example/spec/spec_helper.cr" do |example|
      example.should eq(%{require "spec"
require "../src/example"
})
    end

    describe_file "example/spec/example_spec.cr" do |example|
      example.should eq(%{require "./spec_helper"

describe Example do
  it "works" do
    false.should eq(true)
  end
end
})
    end

    context "with different name" do
      describe_file "another_example/README.md", DIFFERENT_NAME do |readme|
        readme.should be_including("# another_example")

        readme.should be_including(%{```crystal
deps do
  github "[your-github-name]/another_example"
end
```})

        readme.should be_including(%{require "another_example"})

        readme.should be_including(%{1. Fork it ( https://github.com/[your-github-name]/another_example/fork )})

        readme.should be_including(%{[your-github-name](https://github.com/[your-github-name]) John Smith - creator})
      end

      describe_file "another_example/spec/another_example/.keep", DIFFERENT_NAME do |libs_keep|
        libs_keep.should eq("")
      end

      describe_file "another_example/src/another_example.cr", DIFFERENT_NAME do |example|
        example.should eq(%{require "./another_example/*"

module AnotherExample
  # TODO Put your code here
end
})
      end

      describe_file "another_example/src/another_example/version.cr", DIFFERENT_NAME do |version|
        version.should eq(%{module AnotherExample
  VERSION = "0.0.1"
end
})
      end

      describe_file "another_example/spec/spec_helper.cr", DIFFERENT_NAME do |example|
        example.should eq(%{require "spec"
require "../src/another_example"
})
      end

      describe_file "another_example/spec/another_example_spec.cr", DIFFERENT_NAME do |example|
        example.should eq(%{require "./spec_helper"

describe AnotherExample do
  it "works" do
    false.should eq(true)
  end
end
})
      end
    end

    context "with different author" do
      describe_file "example/LICENSE", DIFFERENT_AUTHOR do |license|
        # TODO: Create a library along the lines of ruby timecop and use it here to mock year
        year = Time.now.year
        license.should be_including("Copyright (c) #{year} Mary Johnson")
      end

      describe_file "example/README.md", DIFFERENT_AUTHOR do |readme|
        readme.should be_including(%{[your-github-name](https://github.com/[your-github-name]) Mary Johnson - creator})
      end
    end
  end
end
