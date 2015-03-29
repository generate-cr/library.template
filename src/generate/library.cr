require "ecr/macros"
require "./library/*"

module Generate
  module Library
    extend self

    def run(config)
      Runner.new(config).run
    end
  end
end
