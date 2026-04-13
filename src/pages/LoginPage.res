open Emotion.Css

module Typography = Typography.Typography

@react.component
let make = () => {
  let containerStyles = css({
    "padding": "4rem 1rem",
    "maxWidth": "400px",
    "margin": "0 auto",
    "textAlign": "center",
  })

  <div className={containerStyles}>
    <Typography.Display size=#"3xl"> {React.string("Sign In")} </Typography.Display>
    <Typography.Body
      className={css({"marginTop": "1rem", "color": Theme.Theme.Colors.text["secondary"]})}>
      {React.string("Authentication with OAuth PKCE will be added here.")}
    </Typography.Body>
  </div>
}
