type user = {
  id: string,
  name: string,
  email: string,
}

type authState =
  | LoggedOut
  | LoggedIn(user)

type authContext = {
  state: authState,
  login: unit => promise<unit>,
  logout: unit => unit,
  handleCallback: string => promise<unit>,
}

let oauthConfig: OAuthPkce.config = {
  clientId: "rspack-rescript-template",
  redirectUri: "http://localhost:8080/callback",
  authorizeUrl: "http://localhost:4000/oauth/authorize",
  tokenUrl: "http://localhost:4000/oauth/token",
  scopes: ["openid", "profile", "email"],
}

let context = React.createContext({
  state: LoggedOut,
  login: async () => (),
  logout: () => (),
  handleCallback: async (_) => (),
})

module ContextProvider = {
  let make = React.Context.provider(context)
}

module Provider = {
  @react.component
  let make = (~children) => {
    let (state, setState) = React.useState(() => LoggedOut)

    let setWindowLocation: string => unit = %raw(`function(url) { window.location.href = url }`)

    let login = async () => {
      let url = await OAuthPkce.startAuth(oauthConfig)
      setWindowLocation(url)
    }

    let logout = () => {
      setState(_ => LoggedOut)
    }

    let handleCallback = async (code: string) => {
      let tokenSet = await OAuthPkce.exchangeCode(oauthConfig, code)
      // For the template demo, create a user from the token
      // In production, you'd decode the JWT or call a /userinfo endpoint
      ignore(tokenSet)
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

    <ContextProvider value> {children} </ContextProvider>
  }
}

let useAuth = () => React.useContext(context)
