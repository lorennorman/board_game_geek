require "bundler/setup"

# MiniTest
require "minitest/autorun"
# require 'minitest/reporters'
# MiniTest::Unit.runner = MiniTest::SuiteRunner.new
# MiniTest::Unit.runner.reporters << MiniTest::Reporters::SpecReporter.new

# VCR
require "vcr"

VCR.config do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.stub_with :webmock
end

# System Under Test
require "board_game_geek"


