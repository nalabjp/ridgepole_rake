ENV["RAILS_ENV"] ||= "test"
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'pry'
require 'ridgepole_rake'

require 'minitest/autorun'
