// Enhanced Button component with comprehensive design system integration
open Emotion.Css
open Emotion.Utils

module Button = {
  // Button variant types
  type variant = [#primary | #secondary | #outline | #ghost | #danger]
  type size = [#xs | #sm | #md | #lg | #xl]

  // Base button styles
  let baseStyles = css({
    "display": "inline-flex",
    "alignItems": "center",
    "justifyContent": "center",
    "borderRadius": Border.getRadius("md"),
    "border": "none",
    "cursor": "pointer",
    "fontFamily": "inherit",
    "fontWeight": "500",
    "textDecoration": "none",
    "transition": Animate.getDuration("fast") ++ " ease-out",
    "userSelect": "none",
    "whiteSpace": "nowrap",
    "position": "relative",
    "overflow": "hidden",
    "outline": "none"
  })

  // Size variants
  let getSizeStyles = (size: size) => {
    switch size {
    | #xs => css({
        "height": "2rem",
        "padding": "0 0.75rem",
        "fontSize": "0.875rem"
      })
    | #sm => css({
        "height": "2rem",
        "padding": "0.5rem 0.75rem",
        "fontSize": "0.875rem"
      })
    | #md => css({
        "height": "2.5rem",
        "padding": "0.625rem 1rem",
        "fontSize": "1rem"
      })
    | #lg => css({
        "height": "3rem",
        "padding": "0.75rem 1.25rem",
        "fontSize": "1.125rem"
      })
    | #xl => css({
        "height": "3.5rem",
        "padding": "0.875rem 1.5rem",
        "fontSize": "1.25rem"
      })
    }
  }

  // Variant styles
  let getVariantStyles = (variant: variant) => {
    switch variant {
    | #primary => cx([
        css({
          "backgroundColor": Color.primary,
          "color": "white"
        }),
        hover({"backgroundColor": Color.primaryDark}),
        focus({"boxShadow": Shadow.getFocusShadow("primary")}),
        active({
          "backgroundColor": Color.primaryDark,
          "transform": "translateY(1px)"
        })
      ])
    | #secondary => cx([
        css({
          "backgroundColor": "#e5e7eb",
          "color": "#374151"
        }),
        hover({"backgroundColor": "#d1d5db"}),
        focus({"boxShadow": "0 0 0 2px rgba(156, 163, 175, 0.5)"})
      ])
    | #outline => cx([
        css({
          "backgroundColor": "transparent",
          "color": Color.primary,
          "border": `1px solid ${Color.primary}`
        }),
        hover({
          "backgroundColor": Color.primary,
          "color": "white"
        }),
        focus({"boxShadow": Shadow.getFocusShadow("primary")})
      ])
    | #ghost => cx([
        css({
          "backgroundColor": "transparent",
          "color": Color.primary
        }),
        hover({"backgroundColor": "rgba(100, 108, 255, 0.1)"}),
        focus({"boxShadow": Shadow.getFocusShadow("primary")})
      ])
    | #danger => cx([
        css({
          "backgroundColor": Color.error,
          "color": "white"
        }),
        hover({"backgroundColor": "#dc2626"}),
        focus({"boxShadow": Shadow.getFocusShadow("error")})
      ])
    }
  }

  // State styles
  let getDisabledStyles = () => css({
    "opacity": "0.5",
    "cursor": "not-allowed",
    "pointerEvents": "none"
  })

  let getLoadingStyles = () => css({
    "color": "transparent",
    "position": "relative",
    "pointerEvents": "none"
  })

  let getFullWidthStyles = () => css({
    "width": "100%"
  })

  @react.component
  let make = (
    ~variant: variant=#primary,
    ~size: size=#md,
    ~disabled: bool=false,
    ~loading: bool=false,
    ~fullWidth: bool=false,
    ~leftIcon: option<React.element>=?,
    ~rightIcon: option<React.element>=?,
    ~onClick: option<ReactEvent.Mouse.t => unit>=?,
    ~className: string="",
    ~ariaLabel: option<string>=?,
    ~type_: [#button | #submit | #reset]=#button,
    ~children,
    ()
  ) => {
    let buttonClassName = cx([
      baseStyles,
      getSizeStyles(size),
      getVariantStyles(variant),
      disabled ? getDisabledStyles() : "",
      loading ? getLoadingStyles() : "",
      fullWidth ? getFullWidthStyles() : "",
      className
    ])

    let typeStr = switch type_ {
    | #button => "button"
    | #submit => "submit"
    | #reset => "reset"
    }

    <button
      className={buttonClassName}
      disabled={disabled || loading}
      ?onClick
      ?ariaLabel
      type_={typeStr}>

      {switch leftIcon {
      | Some(icon) => <span className={css({"marginRight": Space.getSpacing("2")})}> {icon} </span>
      | None => React.null
      }}

      {loading ?
        <span className={css({
          "position": "absolute",
          "left": "50%",
          "top": "50%",
          "transform": "translate(-50%, -50%)"
        })}>
          <span className={css({
            "display": "inline-block",
            "width": "1rem",
            "height": "1rem",
            "border": "2px solid transparent",
            "borderTop": "2px solid currentColor",
            "borderRadius": "50%",
            "animation": "spin 1s linear infinite"
          })} />
        </span>
      : React.null}

      <span className={loading ? css({"opacity": "0"}) : ""}> {children} </span>

      {switch rightIcon {
      | Some(icon) => <span className={css({"marginLeft": Space.getSpacing("2")})}> {icon} </span>
      | None => React.null
      }}
    </button>
  }
}
