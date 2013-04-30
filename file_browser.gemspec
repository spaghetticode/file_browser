$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "file_browser/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "file_browser"
  s.version     = FileBrowser::VERSION
  s.authors     = ['Andrea Longhi']
  s.email       = ['andrea@spaghetticode.it']
  s.homepage    = 'https://github.com/spaghetticode/file_browser'
  s.summary     = 'rails engine to add js file browsing'
  s.description = 'rails engine to add js file browsing'

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.13"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "guard-rspec"
end
