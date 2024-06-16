require "uri"

require "../core"
require "../core/utils"

class LogtoClientClass
  class Config
    getter endpoint : URI
    getter app_id : String
    getter app_secret : String
    getter scopes : Array(String)
    getter resources : Array(String)
    getter prompt : Array(String)

    def initialize(
      endpoint : String | URI,
      app_id : String,
      app_secret : String,
      scopes : Array(String) = ["default_scope"],
      resources : Array(String) = ["default_resource"],
      prompt : Array(String) = [LogtoCoreClass::PROMPT[:consent]],
      include_reserved_scopes : Bool = true
    )
        raise ArgumentError.new("Scopes must be an array") if !scopes.is_a?(Array)
        raise ArgumentError.new("Resources must be an array") if !resources.is_a?(Array)
        raise ArgumentError.new("Endpoint must not be empty") if endpoint.nil? || endpoint == ""

      computed_scopes = include_reserved_scopes ? LogtoUtils.with_reserved_scopes(scopes) : scopes

      @endpoint = endpoint.is_a?(URI) ? endpoint : URI.parse(endpoint)
      @app_id = app_id
      @app_secret = app_secret
      @scopes = computed_scopes
      @resources = computed_scopes.includes?(LogtoCoreClass::USER_SCOPE[:organizations]) ? ([LogtoCoreClass::RESERVED_RESOURCE[:organization]] + resources).uniq : resources
      @prompt = prompt
    end
  end

  SignInSession = Struct.new(:redirect_uri, :code_verifier, :state, :post_redirect_uri, keyword_init: true)
end

