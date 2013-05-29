require 'simplecov'
SimpleCov.start
require File.expand_path("../../lib/autofold", __FILE__)
require 'fileutils'
RSpec::Root = File.expand_path("..", __FILE__)