module Infix
  class Config
    attr_accessor :namespace

    def initialize
      @redis_options  = {}
      @namespace      = nil
      yield self if block_given?
    end

    def redis=(options)
      @redis_options = options
    end

    def redis
      @redis ||= Redis::Namespace.new(@namespace, redis: raw_redis)
    end

    def scripts
      @scripts ||= Scripts.new(raw_redis, @namespace)
    end

    private

    def raw_redis
      @raw_redis ||= Redis.new(@redis_options.merge(hiredis: true))
    end
  end
end
