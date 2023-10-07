open Styles

module Button = {
  @react.component
  let make = (~onClick, ~children) =>
    <button onClick className={Styles.button}> {children} </button>
}
