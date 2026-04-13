open Emotion.Css

module Typography = Typography.Typography

@react.component
let make = () => {
  let auth = AuthContext.useAuth()

  React.useEffect0(() => {
    let url = %raw(`new URL(window.location.href)`)
    let code: option<string> = url["searchParams"]["get"]("code")->Nullable.toOption

    switch code {
    | Some(c) =>
      auth.handleCallback(c)
      ->Promise.then(_ => {
        RescriptReactRouter.push("/login")
        Promise.resolve()
      })
      ->ignore
    | None => RescriptReactRouter.push("/login")
    }

    None
  })

  let containerStyles = css({
    "padding": "4rem 1rem",
    "maxWidth": "400px",
    "margin": "0 auto",
    "textAlign": "center",
  })

  <div className={containerStyles}>
    <Typography.Display size=#"2xl"> {React.string("Signing in...")} </Typography.Display>
    <Typography.Body
      className={css({"marginTop": "1rem", "color": Theme.Theme.Colors.text["secondary"]})}>
      {React.string("Completing authentication.")}
    </Typography.Body>
  </div>
}
