require 'yaml'
require 'active_support/core_ext/hash'

require 'ridgepole'

require 'ridgepole_rake/configuration'
require 'ridgepole_rake/option'
require 'ridgepole_rake/command'
require 'ridgepole_rake/tasks'
require 'ridgepole_rake/version'

# Rails
begin
  require 'rails'
  require 'ridgepole_rake/ext/rails'
  require 'ridgepole_rake/railtie'
rescue LoadError
end

#Bundler
begin
  require 'bundler'
  require 'ridgepole_rake/ext/bundler'
rescue LoadError
end

# Brancher
begin
  require 'brancher'
  require 'ridgepole_rake/ext/brancher'
rescue LoadError
end

module RidgepoleRake
  extend self

  def configure
    yield config
  end

  def config
    @config ||= Configuration.new
  end

  def reset
    @config = nil
    config
  end
end
