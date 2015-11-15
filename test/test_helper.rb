ENV["RAILS_ENV"] ||= "test"
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pry'
require 'ridgepole_rake'

require 'minitest/autorun'

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
