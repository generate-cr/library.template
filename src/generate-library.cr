# Example direct usage of Generate::Library

require "./generate/library"
require "logger"

usage="USAGE: generate-library <name>"

if ARGV.count < 1
  puts "<name> argument haven't been specified"
  puts usage
  exit 1
end

name = ARGV.shift
author = `git config --get user.name`.strip

logger = Logger.new(STDOUT)
config = Generate::Library::Config.new(name, author, logger)
Generate::Library.run(config)
