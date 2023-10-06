open Styles

module Container = {
  @react.component
  let make = (~children) => {
    <div className={Styles.container}> {children} </div>
  }
}
