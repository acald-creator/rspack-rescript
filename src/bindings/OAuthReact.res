// --- @cosmonexus/oauth-react bindings (commented out) ---
// Uncomment when the packages are published to npm and
// update AuthContext.res to use AuthProvider and useAuth.
//
// type tokenSet = {
//   accessToken: string,
//   tokenType: string,
//   expiresIn: int,
//   refreshToken: option<string>,
// }
//
// type logoutOptions = {postLogoutRedirectUri?: string}
//
// type authContextValue = {
//   client: OAuthPkce.oauthClient,
//   login: OAuthPkce.authorizeOptions => promise<unit>,
//   logout: logoutOptions => unit,
//   handleCallback: string => OAuthPkce.callbackResult,
//   handleTokenCallback: string => promise<tokenSet>,
//   getTokenEndpoint: unit => string,
//   clearState: unit => unit,
// }
//
// module AuthProvider = {
//   @module("@cosmonexus/oauth-react") @react.component
//   external make: (
//     ~config: OAuthPkce.oauthClientConfig,
//     ~children: React.element,
//   ) => React.element = "AuthProvider"
// }
//
// @module("@cosmonexus/oauth-react")
// external useAuth: unit => authContextValue = "useAuth"
//
// module LoginButton = {
//   @module("@cosmonexus/oauth-react") @react.component
//   external make: (
//     ~provider: string,
//     ~className: string=?,
//     ~children: React.element,
//   ) => React.element = "LoginButton"
// }
//
// @module("@cosmonexus/oauth-react")
// external useOAuthCallback: unit => useOAuthCallbackResult = "useOAuthCallback"
