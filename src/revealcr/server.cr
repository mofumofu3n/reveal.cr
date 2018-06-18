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

      address = server.bind_tcp "127.0.0.1", @port
      puts "Open http://#{address.address}:#{address.port}"
      server.listen
    end

  end
end
