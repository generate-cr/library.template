# Example direct usage of Generate::Library

require "./generate/library"

usage="USAGE: generate-library <name>"

if ARGV.count < 1
  puts "<name> argument haven't been specified"
  puts usage
  exit 1
end

name = ARGV.shift
author = `git config --get user.name`.strip

Generate::Library.run({ :name => name,
                        :author_name => author,
                        :logger => "default",
                        :dir => "." })
