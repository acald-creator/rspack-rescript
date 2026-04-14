// Auth configuration for the template
// Points to the mock server in development
let oauthConfig: OAuthPkce.config = {
  clientId: "rspack-rescript-template",
  redirectUri: "http://localhost:8080/callback",
  authorizeUrl: "http://localhost:4000/oauth/authorize",
  tokenUrl: "http://localhost:4000/oauth/token",
  scopes: ["openid", "profile", "email"],
}

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

let context = React.createContext({
  state: LoggedOut,
  login: async () => (),
  logout: () => (),
  handleCallback: async (_) => (),
})

module ContextProvider = {
  let make = React.Context.provider(context)
}

let setWindowLocation: string => unit = %raw(`function(url) { window.location.href = url }`)

module Provider = {
  @react.component
  let make = (~children) => {
    let (state, setState) = React.useState(() => LoggedOut)

    let login = async () => {
      let url = await OAuthPkce.startAuth(oauthConfig)
      setWindowLocation(url)
    }

    let logout = () => {
      setState(_ => LoggedOut)
      RescriptReactRouter.push("/login")
    }

    let parseCode: string => Nullable.t<string> = %raw(`
      function(search) {
        var url = new URL("http://localhost" + search);
        return url.searchParams.get("code");
      }
    `)

    let handleCallback = async (search: string) => {
      let code: option<string> = parseCode(search)->Nullable.toOption

      switch code {
      | Some(c) => {
          let _tokenSet = await OAuthPkce.exchangeCode(oauthConfig, c)
          // In production, decode the JWT or call /userinfo
          setState(_ => LoggedIn({
            id: "user-1",
            name: "Alice Chen",
            email: "alice@example.com",
          }))
        }
      | None => ()
      }
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

// When @cosmonexus/oauth-react is available, replace Provider above with:
// module Provider = {
//   @react.component
//   let make = (~children) => {
//     <OAuthReact.AuthProvider config={oauthConfig}>
//       {children}
//     </OAuthReact.AuthProvider>
//   }
// }

let useAuth = () => React.useContext(context)
