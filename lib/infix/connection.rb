module Infix
  class Connection
    def initialize(config = Infix.config)
      @config = config
    end

    def index(id, string)
      scripts.index(id, string)
    end

    def search(query)
      scripts.search(query).map do |match|
        { id: match.first, value: match.last }
      end
    end

    def scripts
      @config.scripts
    end

    def redis
      @config.redis
    end
  end
end
