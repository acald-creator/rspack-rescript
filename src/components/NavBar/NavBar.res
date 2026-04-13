open Emotion.Css
open Emotion.Utils

module NavBar = {
  @react.component
  let make = () => {
    let url = RescriptReactRouter.useUrl()
    let currentPath = switch url.path {
    | list{} => "/"
    | list{segment, ..._} => "/" ++ segment
    }

    let navStyles = css({
      "display": "flex",
      "alignItems": "center",
      "justifyContent": "space-between",
      "padding": "1rem 2rem",
      "borderBottom": `1px solid ${Color.border}`,
      "backgroundColor": Color.bgPrimary,
      "position": "sticky",
      "top": "0",
      "zIndex": "100",
    })

    let brandStyles = css({
      "fontSize": "1.25rem",
      "fontWeight": "700",
      "color": Color.textPrimary,
      "cursor": "pointer",
      "textDecoration": "none",
    })

    let linksStyles = css({
      "display": "flex",
      "gap": "1.5rem",
      "alignItems": "center",
    })

    let linkStyles = (~active) =>
      css({
        "color": active ? Color.primary : Color.textSecondary,
        "textDecoration": "none",
        "fontWeight": active ? "600" : "400",
        "fontSize": "0.9375rem",
        "cursor": "pointer",
        "transition": "color 200ms ease-out",
        "borderBottom": active ? `2px solid ${Color.primary}` : "2px solid transparent",
        "paddingBottom": "0.25rem",
      })

    let handleNav = (path, evt: ReactEvent.Mouse.t) => {
      evt->ReactEvent.Mouse.preventDefault
      RescriptReactRouter.push(path)
    }

    <nav className={navStyles}>
      <a className={brandStyles} href="/" onClick={evt => handleNav("/", evt)}>
        {React.string("Rspack + ReScript")}
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
        <a
          className={linkStyles(~active=currentPath == "/login")}
          href="/login"
          onClick={evt => handleNav("/login", evt)}>
          {React.string("Sign In")}
        </a>
      </div>
    </nav>
  }
}
