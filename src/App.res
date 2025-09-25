// Import design system and components
open Emotion.Css
open Emotion.Utils

// Initialize global styles
let _ = Styles.GlobalStyles.initialize()

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
  filter: drop-shadow(0 0 2em #646cffaa);
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
  background: linear-gradient(135deg, #646cff 0%, #535bf2 50%, #4338ca 100%);
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

module Logo = {
  @module("./assets/react.svg") @react.component
  external make: (~role: string=?, ~className: string=?, ~alt: string=?, unit) => React.element =
    "default"
}

// Homepage sections
module HeroSection = {
  @react.component
  let make = () => {
    let (count, setCount) = React.useState(() => 0)

    let heroStyles = css({
      "minHeight": "80vh",
      "display": "flex",
      "flexDirection": "column",
      "alignItems": "center",
      "justifyContent": "center",
      "textAlign": "center",
      "padding": "2rem 1rem",
      "background": "linear-gradient(135deg, rgba(100, 108, 255, 0.1) 0%, rgba(83, 91, 242, 0.1) 100%)"
    })

    let logoContainerStyles = css({
      "display": "flex",
      "gap": "2rem",
      "marginBottom": "2rem",
      "alignItems": "center"
    })

    <section className={heroStyles}>
      <div className={logoContainerStyles}>
        <a href="https://reactjs.org" target="_blank">
          <Logo className="logo react" alt="React logo" />
        </a>
      </div>

      <Components.Typography.Display size=#"4xl" className="hero-gradient">
        {React.string("Modern React Development")}
      </Components.Typography.Display>

      <Components.Typography.Heading level=#h2 size=#xl className={css({"color": "rgba(255, 255, 255, 0.6)", "marginTop": "1rem", "maxWidth": "600px"})}>
        {React.string("Built with Rspack, ReScript, React, and Bun for lightning-fast development")}
      </Components.Typography.Heading>

      <div className={css({"display": "flex", "gap": "1rem", "marginTop": "2rem", "flexWrap": "wrap", "justifyContent": "center"})}>
        <Components.Button
          variant=#primary
          size=#lg
          onClick={_evt => setCount(prev => prev + 1)}>
          {React.string("Interactive Demo (" ++ string_of_int(count) ++ ")")}
        </Components.Button>
        <Components.Button variant=#outline size=#lg>
          {React.string("View Components")}
        </Components.Button>
      </div>
    </section>
  }
}

module FeaturesSection = {
  @react.component
  let make = () => {
    let sectionStyles = css({
      "padding": "4rem 1rem",
      "maxWidth": "1200px",
      "margin": "0 auto"
    })

    let gridStyles = css({
      "display": "grid",
      "gridTemplateColumns": "repeat(auto-fit, minmax(300px, 1fr))",
      "gap": "2rem",
      "marginTop": "3rem"
    })

    let features = [
      ("⚡ Lightning Fast", "Built with Rspack for ultra-fast bundling and hot reload"),
      ("🔧 Type Safety", "ReScript provides bulletproof type safety and excellent ergonomics"),
      ("🎨 Design System", "Comprehensive component library with consistent styling"),
      ("🚀 Modern Stack", "Latest React, Emotion CSS-in-JS, and Bun package manager")
    ]

    <section className={sectionStyles}>
      <Components.Typography.Display size=#"3xl" align=#center>
        {React.string("Why This Template?")}
      </Components.Typography.Display>

      <div className={gridStyles}>
        {features
        |> Belt.Array.map(((title, description)) => {
          <Components.Card key={title} variant=#elevated>
            <Components.Typography.Heading level=#h3 size=#lg>
              {React.string(title)}
            </Components.Typography.Heading>
            <Components.Typography.Body>
              {React.string(description)}
            </Components.Typography.Body>
          </Components.Card>
        })
        |> React.array}
      </div>
    </section>
  }
}

module ComponentsSection = {
  @react.component
  let make = () => {
    let (inputValue, setInputValue) = React.useState(() => "")
    let (selectedCard, setSelectedCard) = React.useState(() => None)

    let sectionStyles = css({
      "padding": "4rem 1rem",
      "backgroundColor": "rgba(45, 45, 45, 0.3)",
      "borderTop": "1px solid #374151"
    })

    let containerStyles = css({
      "maxWidth": "1200px",
      "margin": "0 auto"
    })

    let demoGridStyles = css({
      "display": "grid",
      "gridTemplateColumns": "repeat(auto-fit, minmax(350px, 1fr))",
      "gap": "2rem",
      "marginTop": "3rem"
    })

    <section className={sectionStyles}>
      <div className={containerStyles}>
        <Components.Typography.Display size=#"3xl" align=#center>
          {React.string("Component Library")}
        </Components.Typography.Display>

        <Components.Typography.Body size=#lg align=#center className={css({"marginTop": "1rem", "color": "rgba(255, 255, 255, 0.6)"})}>
          {React.string("Explore our comprehensive component library with variants, sizes, and states")}
        </Components.Typography.Body>

        <div className={demoGridStyles}>
          // Button Variants Demo
          <Components.Card variant=#outlined>
            <Components.Card.Header>
              <Components.Typography.Heading level=#h3>
                {React.string("Button Variants")}
              </Components.Typography.Heading>
            </Components.Card.Header>
            <Components.Card.Body>
              <div className={css({"display": "flex", "flexDirection": "column", "gap": "1rem"})}>
                <Components.Button variant=#primary>
                  {React.string("Primary")}
                </Components.Button>
                <Components.Button variant=#secondary>
                  {React.string("Secondary")}
                </Components.Button>
                <Components.Button variant=#outline>
                  {React.string("Outline")}
                </Components.Button>
                <Components.Button variant=#ghost>
                  {React.string("Ghost")}
                </Components.Button>
                <Components.Button variant=#danger>
                  {React.string("Danger")}
                </Components.Button>
              </div>
            </Components.Card.Body>
          </Components.Card>

          // Input Variants Demo
          <Components.Card variant=#outlined>
            <Components.Card.Header>
              <Components.Typography.Heading level=#h3>
                {React.string("Input Variants")}
              </Components.Typography.Heading>
            </Components.Card.Header>
            <Components.Card.Body>
              <div className={css({"display": "flex", "flexDirection": "column", "gap": "1rem"})}>
                <Components.Input
                  variant=#default
                  placeholder="Default input"
                  value={inputValue}
                  onChange={evt => {
                    let value = ReactEvent.Form.target(evt)["value"]
                    setInputValue(_ => value)
                  }}
                />
                <Components.Input
                  variant=#filled
                  placeholder="Filled input"
                />
                <Components.Input
                  variant=#outlined
                  placeholder="Outlined input"
                />
                <Components.Input
                  variant=#flushed
                  placeholder="Flushed input"
                />
              </div>
            </Components.Card.Body>
          </Components.Card>

          // Typography Demo
          <Components.Card variant=#outlined>
            <Components.Card.Header>
              <Components.Typography.Heading level=#h3>
                {React.string("Typography System")}
              </Components.Typography.Heading>
            </Components.Card.Header>
            <Components.Card.Body>
              <div className={css({"display": "flex", "flexDirection": "column", "gap": "1rem", "textAlign": "left"})}>
                <Components.Typography.Display size=#lg>
                  {React.string("Display Text")}
                </Components.Typography.Display>
                <Components.Typography.Heading level=#h2>
                  {React.string("Heading Text")}
                </Components.Typography.Heading>
                <Components.Typography.Body>
                  {React.string("Body text with proper line height and spacing for optimal readability.")}
                </Components.Typography.Body>
                <Components.Typography.Caption>
                  {React.string("Caption text for additional information")}
                </Components.Typography.Caption>
              </div>
            </Components.Card.Body>
          </Components.Card>
        </div>
      </div>
    </section>
  }
}

module App = {
  @react.component
  let make = () => {
    <div>
      <HeroSection />
      <FeaturesSection />
      <ComponentsSection />

      <footer className={css({"padding": "2rem", "textAlign": "center", "borderTop": "1px solid #374151", "marginTop": "2rem"})}>
        <Components.Typography.Caption>
          {React.string("Built with ❤️ using Rspack + ReScript + React + Bun")}
        </Components.Typography.Caption>
      </footer>
    </div>
  }
}
