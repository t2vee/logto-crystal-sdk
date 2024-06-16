require "http"
require "json"
require "./utils"

class LogtoCoreClass
  struct OidcConfigResponse
    property authorization_endpoint : String?
    property token_endpoint : String?
    property userinfo_endpoint : String?
    property end_session_endpoint : String?
    property revocation_endpoint : String?
    property jwks_uri : String?
    property issuer : String?
    property unknown_keys : Hash(String, JSON::Any)?

    def initialize(
      @authorization_endpoint : String? = nil,
      @token_endpoint : String? = nil,
      @userinfo_endpoint : String? = nil,
      @end_session_endpoint : String? = nil,
      @revocation_endpoint : String? = nil,
      @jwks_uri : String? = nil,
      @issuer : String? = nil,
      @unknown_keys : Hash(String, JSON::Any)? = nil
    )
      end
  end

  struct TokenResponse
    property access_token : String?
    property refresh_token : String?
    property id_token : String?
    property scope : String?
    property token_type : String?
    property expires_in : Int32?
    property unknown_keys : Hash(String, JSON::Any)?

    def initialize(
      @access_token : String? = nil,
      @refresh_token : String? = nil,
      @id_token : String? = nil,
      @scope : String? = nil,
      @token_type : String? = nil,
      @expires_in : Int32? = nil,
      @unknown_keys : Hash(String, JSON::Any)? = nil
    )
      end
  end

  struct IdTokenClaims
    property iss : String
    property sub : String
    property aud : String
    property exp : Int32
    property iat : Int32
    property at_hash : String?
    property name : String?
    property username : String?
    property picture : String?
    property email : String?
    property email_verified : Bool
    property phone_number : String?
    property phone_number_verified : Bool
    property organizations : Array(String)
    property organization_roles : Array(String)
    property roles : Array(String)
    property unknown_keys : Hash(String, JSON::Any)?

    def initialize(
          @iss : String,
          @sub : String,
          @aud : String,
          @exp : Int32,
          @iat : Int32,
          @at_hash : String? = nil,
          @name : String? = nil,
          @username : String? = nil,
          @picture : String? = nil,
          @email : String? = nil,
          @email_verified : Bool = false,
          @phone_number : String? = nil,
          @phone_number_verified : Bool = false,
          @organizations : Array(String) = Array(String).new,
          @organization_roles : Array(String) = Array(String).new,
          @roles : Array(String) = Array(String).new,
          @unknown_keys : Hash(String, JSON::Any)? = nil
        )
      end
  end

  struct UserInfoResponse
    property id_token_claims : IdTokenClaims
    property custom_data : Hash(String, JSON::Any)?
    property identities : Hash(String, JSON::Any)?

    def initialize(
    id_token_claims : IdTokenClaims,
    @custom_data : Hash(String, JSON::Any)? = nil,
    @identities : Hash(String, JSON::Any)? = nil
    )
      @id_token_claims = id_token_claims
    end

    delegate :iss, :sub, :aud, :exp, :iat, :at_hash, :name, :username, :picture, :email, :email_verified, :phone_number, :phone_number_verified, :organizations, :organization_roles, :roles, :unknown_keys, to: @id_token_claims
  end


  struct AccessTokenClaims
    property jti : String
    property iss : String
    property sub : String
    property aud : String
    property exp : Int32
    property iat : Int32
    property client_id : String?
    property scope : String?
    property unknown_keys : Hash(String, JSON::Any)?

    def initialize(
      @jti : String,
      @iss : String,
      @sub : String,
      @aud : String,
      @exp : Int32,
      @iat : Int32,
      @client_id : String? = nil,
      @scope : String? = nil,
      @unknown_keys : Hash(String, JSON::Any)? = nil
    )
      end
  end

  struct AccessToken
    property token : String
    property scope : String
    property expires_at : Int32

    def initialize(
      @token : String,
      @scope : String,
      @expires_at : Int32
    )
      end
  end
end
