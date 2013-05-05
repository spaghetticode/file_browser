$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "fs_browser/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "fs_browser"
  s.version     = FsBrowser::VERSION
  s.authors     = ['Andrea Longhi']
  s.email       = ['andrea@spaghetticode.it']
  s.homepage    = 'https://github.com/spaghetticode/fs_browser'
  s.summary     = 'rails 3 engine to create a modal window to browse the server file system'
  s.description = 'rails 3 engine to create a modal window to browse the server file system'

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 3.2.13"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "guard-rspec"
end
