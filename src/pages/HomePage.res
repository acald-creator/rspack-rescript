open Emotion.Css
open Emotion.Utils

module Components = {
  module Button = Button.Button
  module Typography = Typography.Typography
  module Card = Card.Card
}

module HeroSection = {
  @react.component
  let make = () => {
    let heroStyles = css({
      "maxWidth": "680px",
      "margin": "0 auto",
      "padding": "6rem 1rem 4rem",
      "textAlign": "center",
    })

    let dividerStyles = css({
      "width": "3rem",
      "height": "1px",
      "backgroundColor": Color.border,
      "margin": "2rem auto",
    })

    <section className={heroStyles}>
      <Components.Typography.Overline>
        {React.string("A ReScript Template")}
      </Components.Typography.Overline>
      <Components.Typography.Display size=#"4xl" className={css({"marginTop": "1rem"})}>
        {React.string("Build modern web applications with type safety")}
      </Components.Typography.Display>
      <div className={dividerStyles} />
      <Components.Typography.Body className={css({"color": Color.textSecondary, "fontStyle": "italic"})}>
        {React.string("Rspack, ReScript, React 19, Relay, and Emotion CSS-in-JS working together.")}
      </Components.Typography.Body>
    </section>
  }
}

module FeaturesSection = {
  @react.component
  let make = () => {
    let sectionStyles = css({
      "padding": "2rem 1rem 4rem",
      "maxWidth": "680px",
      "margin": "0 auto",
    })

    let itemStyles = css({
      "borderTop": `1px solid ${Color.border}`,
      "padding": "1.5rem 0",
    })

    let features = [
      ("Rspack", "Rust-based bundler for fast builds and hot module replacement."),
      ("ReScript", "Type-safe language compiling to clean, readable JavaScript."),
      ("Relay", "Declarative data fetching with GraphQL colocated queries."),
      ("Emotion", "CSS-in-JS with a comprehensive design token system."),
    ]

    <section className={sectionStyles}>
      <Components.Typography.Overline className={css({"marginBottom": "1rem"})}>
        {React.string("The Stack")}
      </Components.Typography.Overline>
      {features
      ->Array.map(((title, description)) => {
        <div key={title} className={itemStyles}>
          <Components.Typography.Heading level=#h3 size=#xl>
            {React.string(title)}
          </Components.Typography.Heading>
          <Components.Typography.Body className={css({"color": Color.textSecondary, "margin": "0"})}>
            {React.string(description)}
          </Components.Typography.Body>
        </div>
      })
      ->React.array}
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
