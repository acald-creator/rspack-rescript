open Emotion.Css
open Emotion.Utils

module Divider = {
  @react.component
  let make = (~label: option<string>=?, ~className: string="", ()) => {
    let baseStyles = css({
      "display": "flex",
      "alignItems": "center",
      "gap": "1rem",
      "margin": "2rem 0",
    })

    let lineStyles = css({
      "flex": "1",
      "height": "1px",
      "backgroundColor": Color.border,
    })

    let labelStyles = css({
      "fontFamily": Theme.Theme.Typography.fontFamily["sans"],
      "fontSize": "0.6875rem",
      "fontWeight": "500",
      "letterSpacing": "0.15em",
      "textTransform": "uppercase",
      "color": Color.textSecondary,
    })

    let dividerClassName = cx([baseStyles, className])

    switch label {
    | Some(text) =>
      <div className={dividerClassName}>
        <div className={lineStyles} />
        <span className={labelStyles}> {React.string(text)} </span>
        <div className={lineStyles} />
      </div>
    | None =>
      <div className={dividerClassName}>
        <div className={lineStyles} />
      </div>
    }
  }
}
