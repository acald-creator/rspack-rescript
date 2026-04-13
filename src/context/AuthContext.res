// Auth configuration for the template
// Points to the mock server in development
let oauthConfig: OAuthPkce.oauthClientConfig = {
  issuerBaseUrl: "http://localhost:4000/oauth",
  clientId: "rspack-rescript-template",
  redirectUri: "http://localhost:8080/callback",
  scopes: ["openid", "profile", "email"],
}

// Re-export the provider and hook from @cosmonexus/oauth-react
module Provider = {
  @react.component
  let make = (~children) => {
    <OAuthReact.AuthProvider config={oauthConfig}>
      {children}
    </OAuthReact.AuthProvider>
  }
}

// Simplified auth hook for the template
type user = {
  id: string,
  name: string,
  email: string,
}

type authState =
  | LoggedOut
  | LoggedIn(user)

type authActions = {
  state: authState,
  login: unit => promise<unit>,
  logout: unit => unit,
  handleCallback: string => promise<unit>,
}

// Internal state context for tracking logged-in user
// The OAuth library handles tokens; this tracks the user display state
let userContext = React.createContext({
  state: LoggedOut,
  login: async () => (),
  logout: () => (),
  handleCallback: async (_) => (),
})

module UserContextProvider = {
  let make = React.Context.provider(userContext)
}

module UserProvider = {
  @react.component
  let make = (~children) => {
    let (state, setState) = React.useState(() => LoggedOut)
    let cosmoAuth = OAuthReact.useAuth()

    let login = async () => {
      await cosmoAuth.login({provider: "mock"})
    }

    let logout = () => {
      cosmoAuth.logout()
      setState(_ => LoggedOut)
    }

    let handleCallback = async (search: string) => {
      let _tokenSet = await cosmoAuth.handleTokenCallback(search)
      // In production, decode the JWT or call /userinfo
      setState(_ => LoggedIn({
        id: "user-1",
        name: "Alice Chen",
        email: "alice@example.com",
      }))
    }

    let value = {
      state,
      login,
      logout,
      handleCallback,
    }

    <UserContextProvider value> {children} </UserContextProvider>
  }
}

let useAuth = () => React.useContext(userContext)
