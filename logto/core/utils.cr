require "json"
require "random/secure"
require "./constants"

module LogtoUtils
  def self.parse_json_safe(json_str_or_hash : String | Hash(String, JSON::Type), struct_class)
    data = json_str_or_hash.is_a?(String) ? JSON.parse(json_str_or_hash) : json_str_or_hash
    known_keys = struct_class.members.reject { |k| k == :unknown_keys }
    known_data = data.select { |key, _| known_keys.includes?(key.to_sym) }
    unknown_data = data.reject { |key, _| known_keys.includes?(key.to_sym) }
    struct_class.new(**known_data, unknown_keys: unknown_data)
  end

  def self.with_reserved_scopes(scopes : Array(String)?)
    unique_scopes = scopes || [] of String
    unique_scopes.concat(LogtoCoreClass::RESERVED_SCOPE.values).uniq
  end

  def self.generate_code_verifier
    SecureRandom.urlsafe_base64(32)
  end

  def self.generate_code_challenge(code_verifier : String)
    Base64.urlsafe_encode(Digest::SHA256.digest(code_verifier.to_slice)).tr("=", "")
  end

  def self.generate_state
    SecureRandom.urlsafe_base64(32)
  end

  def self.build_access_token_key(resource : String?, organization_id : String? = nil)
    "#{organization_id ? "##{organization_id}" : ""}:#{resource || "default"}"
  end
end
