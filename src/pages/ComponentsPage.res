open Emotion.Css

module Components = {
  module Button = Button.Button
  module Input = Input.Input
  module Card = Card.Card
  module Typography = Typography.Typography
  module Divider = Divider.Divider
  module Avatar = Avatar.Avatar
  module Badge = Badge.Badge
  module Blockquote = Blockquote.Blockquote
}

@react.component
let make = () => {
  let (inputValue, setInputValue) = React.useState(() => "")

  let sectionStyles = css({
    "padding": "4rem 1rem",
    "maxWidth": "1200px",
    "margin": "0 auto",
  })

  let demoGridStyles = css({
    "display": "grid",
    "gridTemplateColumns": "repeat(auto-fit, minmax(350px, 1fr))",
    "gap": "2rem",
    "marginTop": "3rem",
  })

  <section className={sectionStyles}>
    <Components.Typography.Display size=#"3xl" align=#center>
      {React.string("Component Library")}
    </Components.Typography.Display>
    <Components.Typography.Body
      size=#lg
      align=#center
      className={css({"marginTop": "1rem", "color": Theme.Theme.Colors.text["secondary"]})}>
      {React.string("Explore our comprehensive component library with variants, sizes, and states")}
    </Components.Typography.Body>
    <div className={demoGridStyles}>
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
            <Components.Input variant=#filled placeholder="Filled input" />
            <Components.Input variant=#outlined placeholder="Outlined input" />
            <Components.Input variant=#flushed placeholder="Flushed input" />
          </div>
        </Components.Card.Body>
      </Components.Card>
      <Components.Card variant=#outlined>
        <Components.Card.Header>
          <Components.Typography.Heading level=#h3>
            {React.string("Typography System")}
          </Components.Typography.Heading>
        </Components.Card.Header>
        <Components.Card.Body>
          <div
            className={css({
              "display": "flex",
              "flexDirection": "column",
              "gap": "1rem",
              "textAlign": "left",
            })}>
            <Components.Typography.Display size=#lg>
              {React.string("Display Text")}
            </Components.Typography.Display>
            <Components.Typography.Heading level=#h2>
              {React.string("Heading Text")}
            </Components.Typography.Heading>
            <Components.Typography.Body>
              {React.string(
                "Body text with proper line height and spacing for optimal readability.",
              )}
            </Components.Typography.Body>
            <Components.Typography.Caption>
              {React.string("Caption text for additional information")}
            </Components.Typography.Caption>
          </div>
        </Components.Card.Body>
      </Components.Card>
    </div>
    <Components.Divider label="Editorial Components" />
    <div className={demoGridStyles}>
      <Components.Card variant=#outlined>
        <Components.Card.Header>
          <Components.Typography.Heading level=#h3>
            {React.string("Avatar")}
          </Components.Typography.Heading>
        </Components.Card.Header>
        <Components.Card.Body>
          <div className={css({"display": "flex", "gap": "1rem", "alignItems": "center"})}>
            <Components.Avatar name="Alice Chen" size=#sm />
            <Components.Avatar name="Bob Martinez" size=#md />
            <Components.Avatar name="Carol Davis" size=#lg />
          </div>
        </Components.Card.Body>
      </Components.Card>
      <Components.Card variant=#outlined>
        <Components.Card.Header>
          <Components.Typography.Heading level=#h3>
            {React.string("Badge")}
          </Components.Typography.Heading>
        </Components.Card.Header>
        <Components.Card.Body>
          <div className={css({"display": "flex", "flexWrap": "wrap", "gap": "0.5rem"})}>
            <Components.Badge> {React.string("Default")} </Components.Badge>
            <Components.Badge variant=#primary> {React.string("ReScript")} </Components.Badge>
            <Components.Badge variant=#success> {React.string("Published")} </Components.Badge>
            <Components.Badge variant=#warning> {React.string("Draft")} </Components.Badge>
            <Components.Badge variant=#error> {React.string("Archived")} </Components.Badge>
          </div>
        </Components.Card.Body>
      </Components.Card>
      <Components.Card variant=#outlined>
        <Components.Card.Header>
          <Components.Typography.Heading level=#h3>
            {React.string("Blockquote")}
          </Components.Typography.Heading>
        </Components.Card.Header>
        <Components.Card.Body>
          <Components.Blockquote cite="Rich Hickey">
            {React.string("Simplicity is a prerequisite for reliability.")}
          </Components.Blockquote>
        </Components.Card.Body>
      </Components.Card>
    </div>
  </section>
}
