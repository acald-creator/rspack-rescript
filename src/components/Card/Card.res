// Enhanced Card component with comprehensive design system integration
open Emotion.Css
open Emotion.Utils

module Card = {
  // Card variant types
  type variant = [#elevated | #outlined | #filled]
  type size = [#sm | #md | #lg]
  type padding = [#none | #sm | #md | #lg]

  // Base card styles
  let baseStyles = css({
    "position": "relative",
    "display": "flex",
    "flexDirection": "column",
    "minWidth": "0",
    "wordWrap": "break-word",
    "borderRadius": Border.getRadius("lg"),
    "transition": Animate.getDuration("fast") ++ " ease-out"
  })

  // Variant styles
  let getVariantStyles = (variant: variant) => {
    switch variant {
    | #elevated => css({
        "backgroundColor": "#2d2d2d",
        "boxShadow": "0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1)",
        "border": "1px solid transparent"
      })
    | #outlined => css({
        "backgroundColor": "#1a1a1a",
        "border": "1px solid #374151",
        "boxShadow": "none"
      })
    | #filled => css({
        "backgroundColor": "#333333",
        "border": "1px solid transparent",
        "boxShadow": "none"
      })
    }
  }

  // Size styles
  let getSizeStyles = (size: size) => {
    switch size {
    | #sm => css({
        "maxWidth": "20rem"
      })
    | #md => css({
        "maxWidth": "24rem"
      })
    | #lg => css({
        "maxWidth": "32rem"
      })
    }
  }

  // Padding styles
  let getPaddingStyles = (padding: padding) => {
    switch padding {
    | #none => css({"padding": "0"})
    | #sm => css({"padding": Space.getSpacing("3")})
    | #md => css({"padding": Space.getSpacing("4")})
    | #lg => css({"padding": Space.getSpacing("6")})
    }
  }

  let getInteractiveStyles = () => css({
    "cursor": "pointer",
    ":hover": {
      "transform": "translateY(-1px)",
      "boxShadow": "0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1)"
    }
  })

  @react.component
  let make = (
    ~variant: variant=#elevated,
    ~size: option<size>=?,
    ~padding: padding=#md,
    ~interactive: bool=false,
    ~onClick: option<ReactEvent.Mouse.t => unit>=?,
    ~className: string="",
    ~children,
    ()
  ) => {
    let cardClassName = cx([
      baseStyles,
      getVariantStyles(variant),
      getPaddingStyles(padding),
      interactive ? getInteractiveStyles() : "",
      switch size {
      | Some(s) => getSizeStyles(s)
      | None => ""
      },
      className
    ])

    <div
      className={cardClassName}
      ?onClick>
      {children}
    </div>
  }

  // Card sub-components
  module Header = {
    @react.component
    let make = (~className: string="", ~children, ()) => {
      let headerClassName = cx([
        css({
          "padding": Space.getSpacing("4"),
          "paddingBottom": Space.getSpacing("2"),
          "borderBottom": "1px solid #374151"
        }),
        className
      ])

      <div className={headerClassName}>
        {children}
      </div>
    }
  }

  module Body = {
    @react.component
    let make = (~className: string="", ~children, ()) => {
      let bodyClassName = cx([
        css({
          "padding": Space.getSpacing("4"),
          "flex": "1"
        }),
        className
      ])

      <div className={bodyClassName}>
        {children}
      </div>
    }
  }

  module Footer = {
    @react.component
    let make = (~className: string="", ~children, ()) => {
      let footerClassName = cx([
        css({
          "padding": Space.getSpacing("4"),
          "paddingTop": Space.getSpacing("2"),
          "borderTop": "1px solid #374151",
          "display": "flex",
          "alignItems": "center",
          "justifyContent": "flex-end"
        }),
        className
      ])

      <div className={footerClassName}>
        {children}
      </div>
    }
  }
}