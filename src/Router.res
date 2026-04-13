open Emotion.Css

module NotFound = {
  @react.component
  let make = () => {
    let containerStyles = css({
      "padding": "4rem 1rem",
      "maxWidth": "600px",
      "margin": "0 auto",
      "textAlign": "center",
    })

    <div className={containerStyles}>
      <Typography.Typography.Display size=#"4xl">
        {React.string("404")}
      </Typography.Typography.Display>
      <Typography.Typography.Body
        className={css({"marginTop": "1rem", "color": Theme.Theme.Colors.text["secondary"]})}>
        {React.string("Page not found.")}
      </Typography.Typography.Body>
      <div className={css({"marginTop": "2rem"})}>
        <Button.Button.make
          variant=#primary
          onClick={_evt => RescriptReactRouter.push("/")}>
          {React.string("Go Home")}
        </Button.Button.make>
      </div>
    </div>
  }
}

@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  switch url.path {
  | list{} => <HomePage />
  | list{"components"} => <ComponentsPage />
  | list{"posts"} =>
    <ProtectedRoute.ProtectedRoute>
      <PostsPage />
    </ProtectedRoute.ProtectedRoute>
  | list{"login"} => <LoginPage />
  | list{"callback"} => <CallbackPage />
  | _ => <NotFound />
  }
}
