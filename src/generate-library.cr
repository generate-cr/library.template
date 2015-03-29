require "./generate/library"

usage="USAGE: generate-library <name>"

if ARGV.count < 1
  puts "<name> argument haven't been specified"
  puts usage
  exit 1
end

name = ARGV.shift
author = `git config --get user.name`.strip

config = Generate::Library::Config.new(name, author)
Generate::Library.run(config)
