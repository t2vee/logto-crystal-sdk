require "lru-cache"

class LogtoClientClass
  class AbstractStorage
    def initialize
      raise NotImplementedError
    end

    def get(key)
      raise NotImplementedError
    end

    def set(key, value)
      raise NotImplementedError
    end

    def remove(key)
      raise NotImplementedError
    end
  end

  class SessionStorage < AbstractStorage
    def initialize(session, app_id? : String = nil)
      @session = session
      @app_id = app_id
    end

    def get(key)
      @session[getSessionKey(key)]
    end

    def set(key, value)
      @session[getSessionKey(key)] = value
    end

    def remove(key)
      @session.delete(getSessionKey(key))
    end

    protected def getSessionKey(key)
      "logto_#{@app_id || "default"}_#{key}"
    end
  end

  class CacheStorage < AbstractStorage

    def initialize(app_id? : String = nil)
      @app_id = app_id
      @cache = LRUCache(String, String).new(max_size: 10_000)
    end

    def get(key)
      @cache.get(getCacheKey(key))
    end

    def set(key, value)
      @cache.set(getCacheKey(key), value, force: true)
    end

    def remove(key)
      @cache.delete(getCacheKey(key))
    end

    protected def getCacheKey(key)
      "logto_cache_#{@app_id || "default"}_#{key}"
    end
  end
end
