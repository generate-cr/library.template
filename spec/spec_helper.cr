require "spec"
require "../src/generate/library"
require "yaml"
require "timecop"
require "generate"
require "generate/spec_helper"

module TestSupport
  extend self

  def run_once(options)
    name = options.fetch(:name, "example")
    author_name = options.fetch(:author, "John Smith")
    re_run = options.fetch(:re_run, "false")

    @@_run_once ||= {} of Array(String) => Bool
    already_run = @@_run_once.not_nil!
    already_run[[name, author_name]] = false if re_run != "false"
    already_run[[name, author_name]] ||= _run_once(name, author_name)
  end

  private def _run_once(name, author_name)
    Dir.mkdir_p("tmp/#{name}")
    `rm -r tmp/#{name}`
    Generate.run(["library", name, "--author=#{author_name}", "--logger=null", "--dir=tmp"])
    true
  end
end

define_describe_file "tmp", TestSupport.run_once(options)
