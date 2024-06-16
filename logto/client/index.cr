require "./types"
require "./storage"
require "../core"

class LogtoClientClass
  getter config : LogtoClientClass::Config
  getter navigate : Proc(Int32 | String)
  getter storage : LogtoClientClass::AbstractStorage
  getter cache : LogtoClientClass::AbstractStorage
  getter core : LogtoCoreClass
  getter access_token_map : Hash(String, String)

  def initialize(
    config : LogtoClientClass::Config,
    navigate : Proc,
    storage : LogtoClientClass::AbstractStorage,
    cache : LogtoClientClass::AbstractStorage = CacheStorage.new(app_id: config.app_id)
  )
      raise ArgumentError.new("Config must be a LogtoClientClass::Config") unless config.is_a?(LogtoClientClass::Config)
      raise ArgumentError.new("Navigate must be a Proc") unless navigate.is_a?(Proc)
      raise ArgumentError.new("Storage must be a LogtoClientClass::AbstractStorage") unless storage.is_a?(LogtoClientClass::AbstractStorage)

    @config = config
    @navigate = navigate
    @storage = storage
    @cache = cache
    @core = LogtoCore.new(endpoint: @config.endpoint, cache: cache)
    @access_token_map = @storage.get(STORAGE_KEY[:access_token_map]) || Hash(String, String).new
  end
end
