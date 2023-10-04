%%raw("import './App.css'")

module Logo = {
  @module("./assets/react.svg") @react.component
  external make: (~role: string=?, ~className: string=?, ~alt: string=?, unit) => React.element =
    "default"
}

@react.component
let make = () => {
  let (count, setCount) = React.useState(() => 0)

  let onClick = _evt => {
    setCount(prev => prev + 1)
  }

  <div className="App">
    <div>
      <a href="https://reactjs.org" target="_blank">
        <Logo className="logo react" alt="React logo" />
      </a>
    </div>
    <h1> {React.string("Rspack + Rescript & React + TypeScript on Bun")} </h1>
    <div className="card">
      <button onClick> {React.string("count is " ++ string_of_int(count))} </button>
      <p>
        {React.string("Edit ")}
        <code> {React.string("src/App.res")} </code>
        {React.string(" and save to test HMR")}
      </p>
    </div>
    <p className="read-the-docs">
      {React.string("Click on the Rspack and React logos to learn more")}
    </p>
  </div>
}
