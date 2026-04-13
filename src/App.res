open Emotion.Css

// Initialize global styles
let _ = GlobalStyles.initialize()

Emotion.Css.injectGlobal(`
#root {
  width: 100%;
  min-height: 100vh;
}

.logo {
  height: 6em;
  padding: 1.5em;
  will-change: filter;
}
.logo:hover {
  filter: drop-shadow(0 0 2em ${Theme.Theme.Colors.brand["primary"]}aa);
}
.logo.react:hover {
  filter: drop-shadow(0 0 2em #61dafbaa);
}

@keyframes logo-spin {
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
}

@media (prefers-reduced-motion: no-preference) {
  a:nth-of-type(2) .logo {
    animation: logo-spin infinite 20s linear;
  }
}

/* Hero section gradients */
.hero-gradient {
  background: linear-gradient(135deg, ${Theme.Theme.Colors.brand["primary"]} 0%, ${Theme.Theme.Colors.brand["secondary"]} 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

/* Responsive adjustments */
@media (max-width: 768px) {
  .hero-gradient {
    font-size: 2.5rem;
  }

  .logo {
    height: 4em;
    padding: 1em;
  }
}
`)

module App = {
  @react.component
  let make = () => {
    <RescriptRelayReact.Context.Provider environment={RelayEnv.environment}>
      <div>
        <NavBar.NavBar />
        <main>
          <Router />
        </main>
        <footer
          className={css({
            "padding": "2rem",
            "textAlign": "center",
            "borderTop": `1px solid ${Theme.Theme.Colors.border["default"]}`,
            "marginTop": "2rem",
          })}>
          <Typography.Typography.Caption>
            {React.string("Built with Rspack + ReScript + React + Bun")}
          </Typography.Typography.Caption>
        </footer>
      </div>
    </RescriptRelayReact.Context.Provider>
  }
}
