open Styles

module Label = {
  @react.component
  let make = (~children) => <label className={Styles.label}> {children} </label>
}
