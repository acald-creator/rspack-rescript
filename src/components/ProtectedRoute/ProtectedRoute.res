module ProtectedRoute = {
  @react.component
  let make = (~children) => {
    let auth = AuthContext.useAuth()

    switch auth.state {
    | AuthContext.LoggedOut => {
        RescriptReactRouter.push("/login")
        React.null
      }
    | AuthContext.LoggedIn(_) => children
    }
  }
}
