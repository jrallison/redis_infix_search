require "infix/version"

require "active_support/core_ext"
require "redis"
require "hiredis"
require "redis-namespace"

require "infix/config"
require "infix/scripts"
require "infix/connection"

module Infix
  def self.config
    @config ||= Config.new
  end

  def self.configure
    yield(config)
  end

  def self.reconfigure
    @config = Config.new
    yield(config)
  end
end
