open Emotion.Css

// Initialize global styles
let _ = GlobalStyles.initialize()

Emotion.Css.injectGlobal(`
#root {
  width: 100%;
  min-height: 100vh;
}
`)

module App = {
  @react.component
  let make = () => {
    <AuthContext.Provider>
      <RescriptRelayReact.Context.Provider environment={RelayEnv.environment}>
        <div className={css({"display": "flex", "flexDirection": "column", "minHeight": "100vh"})}>
          <NavBar.NavBar />
          <main className={css({"flex": "1"})}>
            <Router />
          </main>
          <footer
            className={css({
              "padding": "2rem 1rem",
              "textAlign": "center",
              "maxWidth": "680px",
              "margin": "0 auto",
              "width": "100%",
              "borderTop": `1px solid ${Theme.Theme.Colors.border["default"]}`,
            })}>
            <Typography.Typography.Caption>
              {React.string("Built with Rspack + ReScript + React + Bun")}
            </Typography.Typography.Caption>
          </footer>
        </div>
      </RescriptRelayReact.Context.Provider>
    </AuthContext.Provider>
  }
}
