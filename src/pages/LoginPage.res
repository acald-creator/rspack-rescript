open Emotion.Css
open Emotion.Utils

module Typography = Typography.Typography
module Button = Button.Button

@react.component
let make = () => {
  let auth = AuthContext.useAuth()

  let containerStyles = css({
    "padding": "4rem 1rem",
    "maxWidth": "400px",
    "margin": "0 auto",
    "textAlign": "center",
  })

  let cardStyles = css({
    "borderTop": `2px solid ${Color.primary}`,
    "padding": "2rem 0",
    "marginTop": "2rem",
  })

  switch auth.state {
  | AuthContext.LoggedIn(user) =>
    <div className={containerStyles}>
      <Typography.Display size=#"3xl"> {React.string("Welcome back")} </Typography.Display>
      <div className={cardStyles}>
        <Typography.Heading level=#h3> {React.string(user.name)} </Typography.Heading>
        <Typography.Body className={css({"color": Color.textSecondary})}>
          {React.string(user.email)}
        </Typography.Body>
        <div className={css({"marginTop": "1.5rem"})}>
          <Button variant=#outline onClick={_ => auth.logout()}>
            {React.string("Sign Out")}
          </Button>
        </div>
      </div>
    </div>
  | AuthContext.LoggedOut =>
    <div className={containerStyles}>
      <Typography.Display size=#"3xl"> {React.string("Sign In")} </Typography.Display>
      <Typography.Body
        className={css({"marginTop": "1rem", "color": Color.textSecondary})}>
        {React.string("Authenticate using OAuth 2.0 with PKCE.")}
      </Typography.Body>
      <div className={cardStyles}>
        <Typography.Body className={css({"marginBottom": "1.5rem", "color": Color.textSecondary})}>
          {React.string("This template demonstrates the OAuth 2.0 Authorization Code flow with PKCE, using the mock server for local development.")}
        </Typography.Body>
        <Button
          variant=#primary
          fullWidth=true
          onClick={_ => auth.login()->ignore}>
          {React.string("Sign in with OAuth")}
        </Button>
      </div>
    </div>
  }
}
