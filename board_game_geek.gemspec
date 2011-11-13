# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "board_game_geek/version"

Gem::Specification.new do |s|
  s.name        = "board_game_geek"
  s.version     = BoardGameGeek::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Loren Norman"]
  s.email       = ["lorennorman@gmail.com"]
  s.homepage    = "http://github.com/lorennorman/board_game_geek"
  s.summary     = %q{BoardGameGeek.com scraper}
  s.description = %q{We love board games. We love coding. Let's code against the data from BoardGameGeek.com!}

  s.rubyforge_project = "board_game_geek"

  s.add_dependency "nokogiri"
  s.add_development_dependency "minitest"
  s.add_development_dependency "vcr"
  s.add_development_dependency "webmock"
  s.add_development_dependency "rake"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  # s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
