open Emotion.Css

module Components = {
  module Button = Button.Button
  module Typography = Typography.Typography
  module Card = Card.Card
}

module Logo = {
  @module("../assets/react.svg") @react.component
  external make: (~role: string=?, ~className: string=?, ~alt: string=?, unit) => React.element =
    "default"
}

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
      "background": `linear-gradient(180deg, ${Theme.Theme.Colors.brand["primary"]}0a 0%, transparent 100%)`,
    })

    let logoContainerStyles = css({
      "display": "flex",
      "gap": "2rem",
      "marginBottom": "2rem",
      "alignItems": "center",
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
      <Components.Typography.Heading
        level=#h2
        size=#xl
        className={css({
          "color": Theme.Theme.Colors.text["secondary"],
          "marginTop": "1rem",
          "maxWidth": "600px",
        })}>
        {React.string("Built with Rspack, ReScript, React, and Bun for lightning-fast development")}
      </Components.Typography.Heading>
      <div
        className={css({
          "display": "flex",
          "gap": "1rem",
          "marginTop": "2rem",
          "flexWrap": "wrap",
          "justifyContent": "center",
        })}>
        <Components.Button variant=#primary size=#lg onClick={_evt => setCount(prev => prev + 1)}>
          {React.string("Interactive Demo (" ++ Int.toString(count) ++ ")")}
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
      "margin": "0 auto",
    })

    let gridStyles = css({
      "display": "grid",
      "gridTemplateColumns": "repeat(auto-fit, minmax(300px, 1fr))",
      "gap": "2rem",
      "marginTop": "3rem",
    })

    let features = [
      ("Lightning Fast", "Built with Rspack for ultra-fast bundling and hot reload"),
      ("Type Safety", "ReScript provides bulletproof type safety and excellent ergonomics"),
      ("Design System", "Comprehensive component library with consistent styling"),
      ("Modern Stack", "Latest React, Emotion CSS-in-JS, and Bun package manager"),
    ]

    <section className={sectionStyles}>
      <Components.Typography.Display size=#"3xl" align=#center>
        {React.string("Why This Template?")}
      </Components.Typography.Display>
      <div className={gridStyles}>
        {features
        ->Belt.Array.map(((title, description)) => {
          <Components.Card key={title} variant=#elevated>
            <Components.Typography.Heading level=#h3 size=#lg>
              {React.string(title)}
            </Components.Typography.Heading>
            <Components.Typography.Body>
              {React.string(description)}
            </Components.Typography.Body>
          </Components.Card>
        })
        ->React.array}
      </div>
    </section>
  }
}

@react.component
let make = () => {
  <div>
    <HeroSection />
    <FeaturesSection />
  </div>
}
