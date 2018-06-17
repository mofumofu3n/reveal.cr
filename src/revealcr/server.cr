require "http/server"

module Revealcr
  class Server
    def initialize(@port : Int32, @file : String)
    end

    def serve
      server = HTTP::Server.new([
        HTTP::ErrorHandler.new,
        HTTP::LogHandler.new,
        HTTP::CompressHandler.new,
        Handler.new(@file),
      ])

      server.bind_tcp "127.0.0.1", @port
      server.listen
    end

    class Handler
      include HTTP::Handler

      def initialize(@file : String)
      end

      def call(context)
        original_path = context.request.path.not_nil!
        is_dir_path = original_path.ends_with? "/"

        case original_path
        when "/"
          context.response.content_type = "text/html"
          context.response.print Render.new(@file).to_s
        when /^\/revealjs\//
          file_path = "assets#{original_path}"
          context.response.content_type = self.mime_type(file_path)
          File.open(file_path) do |file|
            IO.copy(file, context.response)
          end
        else
          file_path = File.expand_path(original_path[1..-1])
          if File.exists?(file_path)
            context.response.content_type = self.mime_type(file_path)
            File.open(file_path) do |file|
              IO.copy(file, context.response)
            end
          else
            context.response.status_code = 404
            call_next(context)
          end
        end
      end

      private def mime_type(path)
        case path
        when /\.jpg$/
          "image/jpeg"
        when /\.png$/
          "image/png"
        when /\.js$/
          "application/javascript"
        when /\.css$/
          "text/css"
        else
          "text/plain"
        end
      end
    end
  end
end
