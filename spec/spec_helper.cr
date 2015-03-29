require "spec"
require "../src/generate/library"
require "yaml"

module TestSupport
  extend self

  def run_once(options)
    name = options.fetch(:name, "example")
    author_name = options.fetch(:author, "John Smith")

    @@_run_once ||= {} of Array(String) => Bool
    already_run = @@_run_once
    if already_run
      already_run[[name, author_name]] ||= _run_once(name, author_name)
    end
  end

  private def _run_once(name, author_name)
    Dir.mkdir_p("tmp/#{name}")
    `rm -r tmp/#{name}`
    config = Generate::Library::Config.new(name, author_name, "tmp")
    Generate::Library.run(config)
  end

  # Lazy file reference
  struct DescribedFile
    property path
    property options

    def initialize(@path, @options)
    end

    def should(matcher)
      contents.should(matcher)
    end

    def contents
      @_contents ||= _contents
    end

    private def _contents
      TestSupport.run_once(options)
      File.read(path)
    end
  end
end

class IncludeExpectation
  getter value
  getter target

  def initialize(@value)
  end

  def match(target)
    @target = target
    target.to_s.includes?(value)
  end

  def failure_message
    "expected %{#{target}} to include %{#{value}}"
  end

  def negative_failure_message
    "expected %{#{target}} not to include %{#{value}}"
  end
end

def be_including(value)
  IncludeExpectation.new(value)
end

def describe_file(path, options = {} of Symbol => String)
  describe "file #{path}" do
    it "has proper content" do
      yield(TestSupport::DescribedFile.new("tmp/#{path}", options))
    end
  end
end
