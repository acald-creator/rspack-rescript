// Enhanced Input component with comprehensive design system integration
open Emotion.Css
open Emotion.Utils

module Input = {
  // Input variant types
  type variant = [#default | #filled | #outlined | #flushed]
  type size = [#sm | #md | #lg]
  type state = [#default | #error | #success | #warning]

  // Base input styles
  let baseStyles = css({
    "width": "100%",
    "fontFamily": "inherit",
    "fontSize": "inherit",
    "border": "none",
    "outline": "none",
    "transition": Animate.getDuration("fast") ++ " ease-out",
    "position": "relative",
    "backgroundColor": "transparent"
  })

  // Size variants
  let getSizeStyles = (size: size) => {
    switch size {
    | #sm => css({
        "height": "2rem",
        "padding": "0.5rem 0.75rem",
        "fontSize": "0.875rem"
      })
    | #md => css({
        "height": "2.5rem",
        "padding": "0.625rem 0.75rem",
        "fontSize": "1rem"
      })
    | #lg => css({
        "height": "3rem",
        "padding": "0.75rem 1rem",
        "fontSize": "1.125rem"
      })
    }
  }

  // Variant styles
  let getVariantStyles = (variant: variant) => {
    switch variant {
    | #default => cx([
        css({
          "backgroundColor": "#1a1a1a",
          "border": `1px solid #374151`,
          "borderRadius": Border.getRadius("md"),
          "color": "rgba(255, 255, 255, 0.87)"
        }),
        focus({
          "borderColor": Color.primary,
          "boxShadow": Shadow.getFocusShadow("primary")
        })
      ])
    | #filled => cx([
        css({
          "backgroundColor": "#2d2d2d",
          "border": "1px solid transparent",
          "borderRadius": Border.getRadius("md"),
          "color": "rgba(255, 255, 255, 0.87)"
        }),
        hover({"backgroundColor": "#333333"}),
        focus({
          "backgroundColor": "#1a1a1a",
          "borderColor": Color.primary,
          "boxShadow": Shadow.getFocusShadow("primary")
        })
      ])
    | #outlined => cx([
        css({
          "backgroundColor": "transparent",
          "border": `2px solid #374151`,
          "borderRadius": Border.getRadius("md"),
          "color": "rgba(255, 255, 255, 0.87)"
        }),
        focus({
          "borderColor": Color.primary,
          "boxShadow": Shadow.getFocusShadow("primary")
        })
      ])
    | #flushed => cx([
        css({
          "backgroundColor": "transparent",
          "border": "none",
          "borderBottom": `2px solid #374151`,
          "borderRadius": "0",
          "color": "rgba(255, 255, 255, 0.87)",
          "padding": "0.5rem 0"
        }),
        focus({
          "borderBottomColor": Color.primary,
          "boxShadow": `0 1px 0 0 ${Color.primary}`
        })
      ])
    }
  }

  // State styles
  let getStateStyles = (state: state) => {
    switch state {
    | #default => ""
    | #error => css({
        "borderColor": Color.error,
        "color": Color.error
      })
    | #success => css({
        "borderColor": Color.success,
        "color": Color.success
      })
    | #warning => css({
        "borderColor": Color.warning,
        "color": Color.warning
      })
    }
  }

  let getDisabledStyles = () => css({
    "opacity": "0.5",
    "cursor": "not-allowed",
    "pointerEvents": "none"
  })

  let getReadOnlyStyles = () => css({
    "backgroundColor": "#1f1f1f",
    "cursor": "default"
  })

  let getPlaceholderStyles = () => css({
    "::placeholder": {
      "color": "rgba(255, 255, 255, 0.6)",
      "opacity": "1"
    }
  })

  @react.component
  let make = (
    ~variant: variant=#default,
    ~size: size=#md,
    ~state: state=#default,
    ~disabled: bool=false,
    ~readOnly: bool=false,
    ~placeholder: option<string>=?,
    ~value: option<string>=?,
    ~defaultValue: option<string>=?,
    ~onChange: option<ReactEvent.Form.t => unit>=?,
    ~onFocus: option<ReactEvent.Focus.t => unit>=?,
    ~onBlur: option<ReactEvent.Focus.t => unit>=?,
    ~className: string="",
    ~ariaLabel: option<string>=?,
    ~ariaDescribedby: option<string>=?,
    ~id: option<string>=?,
    ~name: option<string>=?,
    ~type_: [#text | #password | #email | #number | #tel | #url | #search]=#text,
    ~autoComplete: option<string>=?,
    ~autoFocus: bool=false,
    ~required: bool=false,
    ~maxLength: option<int>=?,
    ~minLength: option<int>=?,
    ~pattern: option<string>=?,
    ()
  ) => {
    let inputClassName = cx([
      baseStyles,
      getSizeStyles(size),
      getVariantStyles(variant),
      getStateStyles(state),
      getPlaceholderStyles(),
      disabled ? getDisabledStyles() : "",
      readOnly ? getReadOnlyStyles() : "",
      className
    ])

    let typeStr = switch type_ {
    | #text => "text"
    | #password => "password"
    | #email => "email"
    | #number => "number"
    | #tel => "tel"
    | #url => "url"
    | #search => "search"
    }

    <input
      className={inputClassName}
      type_={typeStr}
      ?placeholder
      ?value
      ?defaultValue
      ?onChange
      ?onFocus
      ?onBlur
      ?id
      ?name
      disabled={disabled}
      readOnly={readOnly}
      ?ariaLabel
      ?ariaDescribedby
      ?autoComplete
      autoFocus={autoFocus}
      required={required}
      ?maxLength
      ?minLength
      ?pattern
    />
  }
}
