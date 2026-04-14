open Emotion.Css
open Emotion.Utils

module NavBar = {
  @react.component
  let make = () => {
    let auth = AuthContext.useAuth()
    let url = RescriptReactRouter.useUrl()
    let currentPath = switch url.path {
    | list{} => "/"
    | list{segment, ..._} => "/" ++ segment
    }

    let navStyles = css({
      "display": "flex",
      "alignItems": "center",
      "justifyContent": "space-between",
      "padding": "1.5rem 2rem",
      "backgroundColor": Color.bgPrimary,
      "position": "sticky",
      "top": "0",
      "zIndex": "100",
    })

    let brandStyles = css({
      "fontFamily": Theme.Theme.Typography.fontFamily["serif"],
      "fontSize": "1.5rem",
      "fontWeight": "400",
      "letterSpacing": "-0.02em",
      "color": Color.textPrimary,
      "cursor": "pointer",
      "textDecoration": "none",
    })

    let linksStyles = css({
      "display": "flex",
      "gap": "2rem",
      "alignItems": "center",
    })

    let linkStyles = (~active) =>
      css({
        "color": active ? Color.textPrimary : Color.textSecondary,
        "textDecoration": "none",
        "fontWeight": active ? "600" : "400",
        "fontSize": "0.75rem",
        "letterSpacing": "0.08em",
        "textTransform": "uppercase",
        "cursor": "pointer",
        "transition": "color 200ms ease-out",
      })

    let handleNav = (path, evt: ReactEvent.Mouse.t) => {
      evt->ReactEvent.Mouse.preventDefault
      RescriptReactRouter.push(path)
    }

    <nav className={navStyles}>
      <a className={brandStyles} href="/" onClick={evt => handleNav("/", evt)}>
        {React.string("The Journal")}
      </a>
      <div className={linksStyles}>
        <a
          className={linkStyles(~active=currentPath == "/")}
          href="/"
          onClick={evt => handleNav("/", evt)}>
          {React.string("Home")}
        </a>
        <a
          className={linkStyles(~active=currentPath == "/components")}
          href="/components"
          onClick={evt => handleNav("/components", evt)}>
          {React.string("Components")}
        </a>
        <a
          className={linkStyles(~active=currentPath == "/posts")}
          href="/posts"
          onClick={evt => handleNav("/posts", evt)}>
          {React.string("Posts")}
        </a>
        {switch auth.state {
        | AuthContext.LoggedIn(user) =>
          <a
            className={linkStyles(~active=currentPath == "/login")}
            href="/login"
            onClick={evt => handleNav("/login", evt)}>
            {React.string(user.name)}
          </a>
        | AuthContext.LoggedOut =>
          <a
            className={linkStyles(~active=currentPath == "/login")}
            href="/login"
            onClick={evt => handleNav("/login", evt)}>
            {React.string("Sign In")}
          </a>
        }}
      </div>
    </nav>
  }
}
