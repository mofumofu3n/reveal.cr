require "ecr"

module Revealcr
  class Render
    def initialize(@option : CLI::Option)
    end

    ECR.def_to_s "assets/templates/index.ecr"
  end
end
