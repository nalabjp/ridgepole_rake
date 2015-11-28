require 'active_support/core_ext/hash'

require 'ridgepole'

require 'ridgepole_rake/configuration'
require 'ridgepole_rake/option'
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

require 'ridgepole_rake/railtie' if defined?(Rails)

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
