require "http/server"

module Revealcr
  class Server
    def initialize(@option : CLI::Option)
    end

    def serve
      server = HTTP::Server.new([
        HTTP::ErrorHandler.new,
        HTTP::LogHandler.new,
        HTTP::CompressHandler.new,
        Handler.new(@option),
      ])

      address = server.bind_tcp "127.0.0.1", @option.port
      puts "Open http://#{address.address}:#{address.port}"
      server.listen
    end

  end
end
