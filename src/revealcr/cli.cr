require "file"
require "option_parser"

module Revealcr
  class CLI
    record Option, file : String, port : Int32, theme : String do
      property file, port, theme
    end

    THEMES = %w(
      beige black blood
      league moon night serif
      simple sky solarized white
    )

    def initialize(args = [] of String)
      @option = Option.new("index.md", 4000, "black")
      parse_option!(args)
    end

    def run
      Server.new(@option).serve
    end

    def parse_option!(args)
      parser = OptionParser.parse(args) do |parser|
        parser.banner = "Usage: revealcr [options] [index.md]"
        parser.on("-p PORT", "--port=PORT", "port with running") do |v|
          if /[0-9]+/ =~ v
            @option.port = v.to_i
          else
            STDERR.puts "'PORT' is only numeric value."
            STDERR.puts ""
            STDERR.puts parser
            exit(1)
          end
        end
        parser.on("-t THEME", "--theme=THEME", "presentation theme (#{THEMES.join("|")})") do |v|
          if THEMES.includes?(v)
            @option.theme = v
          else
            STDERR.puts "'#{v}' theme is not found.\nYou can select from (#{THEMES.join("|")})"
            STDERR.puts ""
            STDERR.puts parser
            exit(1)
          end
        end
        parser.on("-h", "--help", "Show this help") { puts parser; exit(0) }
        parser.invalid_option do |flag|
          STDERR.puts "ERROR: #{flag} is not a valid option."
          STDERR.puts ""
          STDERR.puts parser
          exit(1)
        end
      end

      @option.file = args.first? || @option.file

      if !File.exists?(@option.file)
        STDERR.puts "[ERROR] #{@option.file} not found."
        STDERR.puts ""
        STDERR.puts parser
        exit(1)
      end
    end
  end
end
