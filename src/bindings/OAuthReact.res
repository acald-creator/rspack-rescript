// ReScript bindings for @cosmonexus/oauth-react

type tokenSet = {
  accessToken: string,
  tokenType: string,
  expiresIn: int,
  refreshToken: option<string>,
}

type authContextValue = {
  client: OAuthPkce.oauthClient,
  login: OAuthPkce.authorizeOptions => promise<unit>,
  logout: unit => unit,
  handleCallback: string => OAuthPkce.callbackResult,
  handleTokenCallback: string => promise<tokenSet>,
  getTokenEndpoint: unit => string,
  clearState: unit => unit,
}

module AuthProvider = {
  @module("@cosmonexus/oauth-react") @react.component
  external make: (
    ~config: OAuthPkce.oauthClientConfig,
    ~children: React.element,
  ) => React.element = "AuthProvider"
}

@module("@cosmonexus/oauth-react")
external useAuth: unit => authContextValue = "useAuth"

module LoginButton = {
  @module("@cosmonexus/oauth-react") @react.component
  external make: (
    ~provider: string,
    ~className: string=?,
    ~children: React.element,
  ) => React.element = "LoginButton"
}

type useOAuthCallbackResult = {
  isProcessing: bool,
  error: option<string>,
  result: option<OAuthPkce.callbackResult>,
}

@module("@cosmonexus/oauth-react")
external useOAuthCallback: unit => useOAuthCallbackResult = "useOAuthCallback"
