require "../spec_helper.cr"
require "../../src/revealcr/cli"

describe Revealcr::CLI do
  it "sets theme" do
    cli = Revealcr::CLI.new
    cli.set_theme("black").should be_true
  end

  it "is invalid theme" do
    cli = Revealcr::CLI.new
    cli.set_theme("hoge").should be_false
  end
end
