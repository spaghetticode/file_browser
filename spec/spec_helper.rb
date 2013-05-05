# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../dummy/config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'fakefs/spec_helpers'
require 'capybara/rails'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.infer_base_class_for_anonymous_controllers = false
  config.order = 'random'
  config.include SpecHelpers
  # otherwise controller specs won't recognize mounted routes
  config.before(:each, type: :controller) { @routes = FsBrowser::Engine.routes }
end
