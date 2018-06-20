require "file"
require "option_parser"

module Revealcr
  class CLI
    getter option : Option

    record Option, file : String, port : Int32, theme : String do
      property file, port, theme
    end

    THEMES = %w(
      beige black blood
      league moon night serif
      simple sky solarized white
    )

    def initialize
      @option = Option.new("index.md", 4000, "black")
    end

    def run(args)
      parse_option!(args)
      Server.new(@option).serve
    end

    def parse_option!(args)
      parser = OptionParser.parse(args) do |parser|
        parser.banner = "Usage: revealcr [options] [index.md]"
        parser.on("-p PORT", "--port=PORT", "port with running. default: 4000") do |v|
          if /[0-9]+/ =~ v
            @option.port = v.to_i
          else
            error(parser, "'PORT' is only numeric value.")
          end
        end
        parser.on("-t THEME", "--theme=THEME", "presentation theme. default: black (#{THEMES.join("|")})") do |v|
          unless set_theme(v)
            error(parser, "'#{v}' theme is not found.\nYou can select from (#{THEMES.join("|")})")
          end
        end
        parser.on("-h", "--help", "Show this help") { puts parser; exit(0) }
        parser.invalid_option do |flag|
          error(parser, "ERROR: #{flag} is not a valid option.")
        end
      end

      @option.file = args.first? || @option.file

      if !File.exists?(@option.file)
        error(parser, "[ERROR] #{@option.file} not found.")
      end
    end

    def set_theme(value)
      if THEMES.includes?(value)
        @option.theme = value
        true
      else
        false
      end
    end

    def error(parser, message)
      STDERR.puts message
      STDERR.puts ""
      STDERR.puts parser
      exit(1)
    end
  end
end
