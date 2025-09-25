// Enhanced Typography components with comprehensive design system integration
open Emotion.Css
open Emotion.Utils

module Typography = {
  // Typography variant types
  type variant = [#display | #heading | #body | #caption | #overline]
  type size = [#xs | #sm | #md | #lg | #xl | #"2xl" | #"3xl" | #"4xl"]
  type weight = [#light | #normal | #medium | #semibold | #bold]
  type align = [#left | #center | #right | #justify]

  // Base typography styles
  let baseStyles = css({
    "margin": "0",
    "fontFamily": "Inter, Avenir, Helvetica, Arial, sans-serif",
    "lineHeight": "1.5",
    "color": "rgba(255, 255, 255, 0.87)"
  })

  // Variant styles
  let getVariantStyles = (variant: variant) => {
    switch variant {
    | #display => css({
        "fontSize": "3rem",
        "fontWeight": "700",
        "lineHeight": "1.1",
        "letterSpacing": "-0.025em"
      })
    | #heading => css({
        "fontSize": "1.5rem",
        "fontWeight": "600",
        "lineHeight": "1.25",
        "letterSpacing": "-0.025em"
      })
    | #body => css({
        "fontSize": "1rem",
        "fontWeight": "400",
        "lineHeight": "1.5"
      })
    | #caption => css({
        "fontSize": "0.875rem",
        "fontWeight": "400",
        "lineHeight": "1.25",
        "color": "rgba(255, 255, 255, 0.6)"
      })
    | #overline => css({
        "fontSize": "0.75rem",
        "fontWeight": "500",
        "lineHeight": "1.25",
        "letterSpacing": "0.1em",
        "textTransform": "uppercase",
        "color": "rgba(255, 255, 255, 0.6)"
      })
    }
  }

  // Size styles
  let getSizeStyles = (size: size) => {
    switch size {
    | #xs => css({"fontSize": "0.75rem"})
    | #sm => css({"fontSize": "0.875rem"})
    | #md => css({"fontSize": "1rem"})
    | #lg => css({"fontSize": "1.125rem"})
    | #xl => css({"fontSize": "1.25rem"})
    | #"2xl" => css({"fontSize": "1.5rem"})
    | #"3xl" => css({"fontSize": "1.875rem"})
    | #"4xl" => css({"fontSize": "2.25rem"})
    }
  }

  // Weight styles
  let getWeightStyles = (weight: weight) => {
    switch weight {
    | #light => css({"fontWeight": "300"})
    | #normal => css({"fontWeight": "400"})
    | #medium => css({"fontWeight": "500"})
    | #semibold => css({"fontWeight": "600"})
    | #bold => css({"fontWeight": "700"})
    }
  }

  // Align styles
  let getAlignStyles = (align: align) => {
    switch align {
    | #left => css({"textAlign": "left"})
    | #center => css({"textAlign": "center"})
    | #right => css({"textAlign": "right"})
    | #justify => css({"textAlign": "justify"})
    }
  }

  let getTruncateStyles = () => css({
    "overflow": "hidden",
    "textOverflow": "ellipsis",
    "whiteSpace": "nowrap"
  })

  @react.component
  let make = (
    ~variant: variant=#body,
    ~size: option<size>=?,
    ~weight: option<weight>=?,
    ~align: align=#left,
    ~truncate: bool=false,
    ~color: option<string>=?,
    ~className: string="",
    ~as_: [#h1 | #h2 | #h3 | #h4 | #h5 | #h6 | #p | #span | #div]=#p,
    ~children,
    ()
  ) => {
    let textClassName = cx([
      baseStyles,
      getVariantStyles(variant),
      getAlignStyles(align),
      truncate ? getTruncateStyles() : "",
      switch size {
      | Some(s) => getSizeStyles(s)
      | None => ""
      },
      switch weight {
      | Some(w) => getWeightStyles(w)
      | None => ""
      },
      switch color {
      | Some(c) => css({"color": c})
      | None => ""
      },
      className
    ])

    switch as_ {
    | #h1 => <h1 className={textClassName}> {children} </h1>
    | #h2 => <h2 className={textClassName}> {children} </h2>
    | #h3 => <h3 className={textClassName}> {children} </h3>
    | #h4 => <h4 className={textClassName}> {children} </h4>
    | #h5 => <h5 className={textClassName}> {children} </h5>
    | #h6 => <h6 className={textClassName}> {children} </h6>
    | #p => <p className={textClassName}> {children} </p>
    | #span => <span className={textClassName}> {children} </span>
    | #div => <div className={textClassName}> {children} </div>
    }
  }

  // Specialized typography components
  module Display = {
    @react.component
    let make = (
      ~size: size=#"4xl",
      ~weight: weight=#bold,
      ~align: align=#left,
      ~color: option<string>=?,
      ~className: string="",
      ~children,
      ()
    ) => {
      <Typography.make
        variant=#display
        size={size}
        weight={weight}
        align={align}
        ?color
        className={className}
        as_=#h1>
        {children}
      </Typography.make>
    }
  }

  module Heading = {
    @react.component
    let make = (
      ~level: [#h1 | #h2 | #h3 | #h4 | #h5 | #h6]=#h2,
      ~size: option<size>=?,
      ~weight: weight=#semibold,
      ~align: align=#left,
      ~color: option<string>=?,
      ~className: string="",
      ~children,
      ()
    ) => {
      let defaultSize = switch level {
      | #h1 => #"3xl"
      | #h2 => #"2xl"
      | #h3 => #xl
      | #h4 => #lg
      | #h5 => #md
      | #h6 => #sm
      }

      <Typography.make
        variant=#heading
        size={Belt.Option.getWithDefault(size, defaultSize)}
        weight={weight}
        align={align}
        ?color
        className={className}
        as_={level}>
        {children}
      </Typography.make>
    }
  }

  module Body = {
    @react.component
    let make = (
      ~size: size=#md,
      ~weight: weight=#normal,
      ~align: align=#left,
      ~color: option<string>=?,
      ~className: string="",
      ~as_: [#p | #span | #div]=#p,
      ~children,
      ()
    ) => {
      <Typography.make
        variant=#body
        size={size}
        weight={weight}
        align={align}
        ?color
        className={className}
        as_={as_}>
        {children}
      </Typography.make>
    }
  }

  module Caption = {
    @react.component
    let make = (
      ~size: size=#sm,
      ~weight: weight=#normal,
      ~align: align=#left,
      ~color: option<string>=?,
      ~className: string="",
      ~as_: [#p | #span | #div]=#span,
      ~children,
      ()
    ) => {
      <Typography.make
        variant=#caption
        size={size}
        weight={weight}
        align={align}
        ?color
        className={className}
        as_={as_}>
        {children}
      </Typography.make>
    }
  }

  module Overline = {
    @react.component
    let make = (
      ~size: size=#xs,
      ~weight: weight=#medium,
      ~align: align=#left,
      ~color: option<string>=?,
      ~className: string="",
      ~as_: [#p | #span | #div]=#span,
      ~children,
      ()
    ) => {
      <Typography.make
        variant=#overline
        size={size}
        weight={weight}
        align={align}
        ?color
        className={className}
        as_={as_}>
        {children}
      </Typography.make>
    }
  }
}