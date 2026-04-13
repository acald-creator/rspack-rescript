// ReScript bindings for @cosmonexus/oauth-client

type oauthClientConfig = {
  issuerBaseUrl: string,
  clientId: string,
  redirectUri?: string,
  scopes?: array<string>,
  storagePrefix?: string,
}

type authorizeOptions = {
  provider: string,
  flow?: [#login | #signup | #verify],
}

type urlObj
@send external toString: urlObj => string = "toString"

type authorizeResult = {
  url: urlObj,
  codeVerifier: string,
  state: string,
}

type callbackResult = {
  code: string,
  state: string,
  codeVerifier: string,
}

type tokenExchangePayload = {
  grant_type: string,
  code: string,
  code_verifier: string,
  redirect_uri: string,
  client_id: string,
}

type oauthClient

@new @module("@cosmonexus/oauth-client")
external makeClient: oauthClientConfig => oauthClient = "OAuthClient"

@send
external authorize: (oauthClient, authorizeOptions) => promise<authorizeResult> = "authorize"

@send
external login: (oauthClient, authorizeOptions) => promise<unit> = "login"

@send
external handleCallback: (oauthClient, string) => callbackResult = "handleCallback"

@send
external buildTokenPayload: (oauthClient, callbackResult) => tokenExchangePayload =
  "buildTokenPayload"

@send
external getTokenEndpoint: oauthClient => string = "getTokenEndpoint"

@send
external logout: oauthClient => unit = "logout"

@send
external clearState: oauthClient => unit = "clearState"
