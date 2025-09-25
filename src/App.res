open Container
open Button
open Label
open Input

Emotion.Css.injectGlobal(`
#root {
  max-width: 1280px;
  margin: 0 auto;
  padding: 2rem;
  text-align: center;
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

.card {
  padding: 2em;
}

.read-the-docs {
  color: #888;
}

/* Responsive adjustments */
@media (max-width: 768px) {
  #root {
    padding: 1rem;
  }
  .logo {
    height: 4em;
    padding: 1em;
  }
  h1 {
    font-size: 2em;
  }
}
`)

module Logo = {
  @module("./assets/react.svg") @react.component
  external make: (~role: string=?, ~className: string=?, ~alt: string=?, unit) => React.element =
    "default"
}

module App = {
  @react.component
  let make = () => {
    let (count, setCount) = React.useState(() => 0)

    let onClick = _evt => {
      setCount(prev => prev + 1)
    }

    // Example of using Emotion Utils for hover effect
    let cardStyle = Emotion.Css.cx([
      "card",
      Emotion.Css.css({
        "border": "1px solid #646cff",
        "border-radius": "8px",
        "transition": "border-color 0.3s ease",
      }),
      Emotion.Utils.hover({"border-color": "#535bf2"})
    ])

    let titleStyle = Emotion.Css.css({
      "color": "#646cff",
      "margin-bottom": "1rem",
    })

    <Container>
      <div>
        <a href="https://reactjs.org" target="_blank">
          <Logo className="logo react" alt="React logo" />
        </a>
      </div>
      <h1 className={titleStyle}>
        {React.string("Rspack + Rescript & React + TypeScript on Bun")}
      </h1>
      <div className={cardStyle}>
        <Button onClick> {React.string("count is " ++ string_of_int(count))} </Button>
        <p>
          {React.string("Example Input field below")}
          <br />
          <Input />
          <br />
          <Label> {React.string("Example label")} </Label>
          <br />
          {React.string("Edit ")}
          <code> {React.string("src/App.res")} </code>
          {React.string(" and save to test HMR")}
        </p>
      </div>
      <p className="read-the-docs">
        {React.string("Click on the Rspack and React logos to learn more")}
      </p>
    </Container>
  }
}
