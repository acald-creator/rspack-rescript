open Emotion.Css
open Emotion.Utils

module Badge = {
  type variant = [#default | #primary | #success | #warning | #error]

  @react.component
  let make = (~variant: variant=#default, ~className: string="", ~children, ()) => {
    let baseStyles = css({
      "display": "inline-flex",
      "alignItems": "center",
      "fontFamily": Theme.Theme.Typography.fontFamily["sans"],
      "fontSize": "0.6875rem",
      "fontWeight": "500",
      "letterSpacing": "0.05em",
      "textTransform": "uppercase",
      "padding": "0.25rem 0.625rem",
      "borderRadius": "2px",
      "lineHeight": "1.25",
    })

    let variantStyles = switch variant {
    | #default => css({
        "backgroundColor": Color.bgElevated,
        "color": Color.textSecondary,
        "border": `1px solid ${Color.border}`,
      })
    | #primary => css({
        "backgroundColor": `${Color.primary}1a`,
        "color": Color.primary,
        "border": `1px solid ${Color.primary}33`,
      })
    | #success => css({
        "backgroundColor": "rgba(34, 197, 94, 0.1)",
        "color": Color.success,
        "border": "1px solid rgba(34, 197, 94, 0.2)",
      })
    | #warning => css({
        "backgroundColor": "rgba(245, 158, 11, 0.1)",
        "color": Color.warning,
        "border": "1px solid rgba(245, 158, 11, 0.2)",
      })
    | #error => css({
        "backgroundColor": "rgba(239, 68, 68, 0.1)",
        "color": Color.error,
        "border": "1px solid rgba(239, 68, 68, 0.2)",
      })
    }

    let badgeClassName = cx([baseStyles, variantStyles, className])

    <span className={badgeClassName}> {children} </span>
  }
}
