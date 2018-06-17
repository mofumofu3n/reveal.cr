require "ecr"

module Revealcr
  class Render
    def initialize(@file_name : String)
    end

    ECR.def_to_s "assets/templates/index.ecr"
  end
end
