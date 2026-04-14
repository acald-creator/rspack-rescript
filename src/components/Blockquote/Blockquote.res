open Emotion.Css
open Emotion.Utils

module Blockquote = {
  @react.component
  let make = (~cite: option<string>=?, ~className: string="", ~children, ()) => {
    let quoteStyles = css({
      "fontFamily": Theme.Theme.Typography.fontFamily["serif"],
      "fontSize": "1.375rem",
      "fontWeight": "400",
      "fontStyle": "italic",
      "lineHeight": "1.6",
      "color": Color.textPrimary,
      "borderLeft": `3px solid ${Color.primary}`,
      "paddingLeft": "1.5rem",
      "margin": "2rem 0",
    })

    let citeStyles = css({
      "display": "block",
      "marginTop": "0.75rem",
      "fontFamily": Theme.Theme.Typography.fontFamily["sans"],
      "fontSize": "0.8125rem",
      "fontStyle": "normal",
      "fontWeight": "400",
      "letterSpacing": "0.05em",
      "color": Color.textSecondary,
    })

    let quoteClassName = cx([quoteStyles, className])

    <blockquote className={quoteClassName}>
      {children}
      {switch cite {
      | Some(attribution) =>
        <cite className={citeStyles}> {React.string({`\u2014 `} ++ attribution)} </cite>
      | None => React.null
      }}
    </blockquote>
  }
}
