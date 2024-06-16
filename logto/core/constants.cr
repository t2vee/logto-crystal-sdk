class LogtoCoreClass
  DISCOVERY_PATH = "/oidc/.well-known/openid-configuration"

  QUERY_KEY = {
    client_id: "client_id",
    client_secret: "client_secret",
    token: "token",
    code: "code",
    code_verifier: "code_verifier",
    code_challenge: "code_challenge",
    code_challenge_method: "code_challenge_method",
    prompt: "prompt",
    redirect_uri: "redirect_uri",
    post_logout_redirect_uri: "post_logout_redirect_uri",
    grant_type: "grant_type",
    refresh_token: "refresh_token",
    scope: "scope",
    state: "state",
    response_type: "response_type",
    resource: "resource",
    organization_id: "organization_id",
    login_hint: "login_hint",
    direct_sign_in: "direct_sign_in",
    first_screen: "first_screen",
    interaction_mode: "interaction_mode",
    error: "error",
    error_description: "error_description"
  }

  TOKEN_GRANT_TYPE = {
    authorization_code: "authorization_code",
    refresh_token: "refresh_token"
  }

  CODE_CHALLENGE_METHOD = {
    S256: "S256"
  }

  PROMPT = {
    login: "login",
    none: "none",
    consent: "consent",
    select_account: "select_account"
  }

  RESERVED_SCOPE = {
    openid: "openid",
    offline_access: "offline_access",
    profile: "profile"
  }

  USER_SCOPE = {
    profile: "profile",
    email: "email",
    phone: "phone",
    custom_data: "custom_data",
    identities: "identities",
    roles: "roles",
    organizations: "urn:logto:scope:organizations",
    organization_roles: "urn:logto:scope:organization_roles"
  }

  RESERVED_RESOURCE = {
    organization: "urn:logto:resource:organizations"
  }
end
