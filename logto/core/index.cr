require "http/client"
require "uri"

require "./types"
require "./constants"

class LogtoCoreClass
  getter oidc_config : LogtoCoreClass::OidcConfigResponse
  getter endpoint : URI

  def initialize(endpoint, cache)
    @endpoint = endpoint
    @cache = cache
    @oidc_config = fetch_oidc_config
  end

  protected def fetch_oidc_config
    config_hash = @cache.get("oidc_config") || begin
      response = HTTP::Client.get(URI.join(endpoint, DISCOVERY_PATH))
      @cache.set("oidc_config", response)#&
      response
    end
    LogtoUtils.parse_json_safe(config_hash, OidcConfigResponse)
  end
end
