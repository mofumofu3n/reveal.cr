require "../spec_helper.cr"
require "../../src/revealcr/cli"
require "../../src/revealcr/handler"

describe Revealcr::Handler do
  it "detect mime_type" do
    option = Revealcr::CLI::Option.new
    handler = Revealcr::Handler.new(option)
    handler.mime_type(".jpg").should eq("image/jpeg")
  end

  it "detect invalid mime_type" do
    option = Revealcr::CLI::Option.new
    handler = Revealcr::Handler.new(option)
    handler.mime_type(".hoge").should eq("text/plain")
  end
end

