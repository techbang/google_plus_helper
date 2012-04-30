# -*- encoding: utf-8 -*-
require File.expand_path('../lib/google_plus_helper/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["chitsaou"]
  gem.email         = ["chitsaou@techbang.com.tw"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "google_plus_helper"
  gem.require_paths = ["lib"]
  gem.version       = GooglePlusHelper::VERSION

  gem.add_dependency("rails", ">= 3.0")
end
