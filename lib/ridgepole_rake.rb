require 'active_support/core_ext/hash'
require 'active_support/configurable'
require 'ridgepole_rake/configuration'
require 'ridgepole_rake/command'
require 'ridgepole_rake/tasks'
require 'ridgepole_rake/version'

%w(
  rails
  bundler
  brancher
).each do |extension|
  begin
    require extension
    require "ridgepole_rake/ext/#{extension}"
  rescue LoadError
  end
end

module RidgepoleRake
  extend self

  def configure
    yield config
  end

  def config
    @config ||= Configuration.new
  end
end
