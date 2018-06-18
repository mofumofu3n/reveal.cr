require "file"
require "option_parser"

module Revealcr
  class CLI
    @port = 8080
    @file = "index.md"

    def initialize(args = [] of String)
      parse_option!(args)
    end

    def run
      Server.new(@port, @file).serve
    end

    def parse_option!(args)
      parser = OptionParser.parse(args) do |parser|
        parser.banner = "Usage: revealcr [options] [index.md]"
        parser.on("-p PORT", "--port=PORT", "port with running") do |v|
          if /[0-9]+/ =~ v
            @port = v.to_i
          else
            STDERR.puts "'PORT' is only numeric value."
            STDERR.puts parser
            exit(1)
          end
        end
        parser.on("-h", "--help", "Show this help") { puts parser; exit(0) }
        parser.invalid_option do |flag|
          STDERR.puts "ERROR: #{flag} is not avalid option."
          STDERR.puts parser
          exit(1)
        end
      end

      @file = args.first? || @file

      if !File.exists?(@file)
        STDERR.puts "[ERROR] #{@file} not found."
        STDERR.puts parser
        exit(1)
      end
    end
  end
end
