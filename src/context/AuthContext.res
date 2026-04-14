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

type callbackParams = {code: Nullable.t<string>, state: Nullable.t<string>}

let parseCallbackParams: string => callbackParams = %raw(`
  function(search) {
    var url = new URL("http://localhost" + search);
    return { code: url.searchParams.get("code"), state: url.searchParams.get("state") };
  }
`)

let getStoredState: unit => Nullable.t<string> = %raw(`
  function() { return sessionStorage.getItem("pkce_state"); }
`)

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

    let handleCallback = async (search: string) => {
      let params = parseCallbackParams(search)
      let code = params.code->Nullable.toOption
      let returnedState = params.state->Nullable.toOption
      let storedState = getStoredState()->Nullable.toOption

      switch (code, returnedState, storedState) {
      | (Some(c), Some(rs), Some(ss)) if rs === ss => {
          let _tokenSet = await OAuthPkce.exchangeCode(oauthConfig, c)
          // In production, decode the JWT or call /userinfo
          setState(_ => LoggedIn({
            id: "user-1",
            name: "Alice Chen",
            email: "alice@example.com",
          }))
        }
      | (_, Some(_), _) =>
        Console.error("OAuth callback state mismatch — possible CSRF attack. Aborting.")
      | _ => ()
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
