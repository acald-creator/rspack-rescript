module Css = {
  @module("@emotion/css") external css: {..} => string = "css"
  @module("@emotion/css") external rawCss: string => string = "css"
  @module("@emotion/css") external keyframes: {..} => string = "keyframes"
  @module("@emotion/css") external cx: array<string> => string = "cx"
  @module("@emotion/css") external injectGlobal: string => unit = "injectGlobal"
  @module("@emotion/css") external cache: {..} = "cache"
  @module("@emotion/css") external hydrate: array<string> => unit = "hydrate"
  @module("@emotion/css") external getRegisteredStyles: unit => array<string> = "getRegisteredStyles"
  @module("@emotion/css") external flush: unit => unit = "flush"

  // Additional emotion/css APIs
  @module("@emotion/css") external merge: array<string> => string = "merge"
  @module("@emotion/css") external sheet: {..} = "sheet"
}

module Server = {
  @module("@emotion/server")
  external renderStylesToString: string => string = "renderStylesToString"
  @module("@emotion/server")
  external extractCritical: string => {..} = "extractCritical"
}

// Utility helpers for common CSS patterns
module Utils = {
  open Css
  open Theme

  // Pseudo-class helpers with theme integration
  let hover = styles => css({":hover": styles})
  let focus = styles => css({":focus": styles})
  let active = styles => css({":active": styles})
  let disabled = styles => css({":disabled": styles})
  let firstChild = styles => css({":first-child": styles})
  let lastChild = styles => css({":last-child": styles})

  // Responsive helpers using theme breakpoints
  module Responsive = {
    // For now, use raw CSS strings for media queries
    let sm = styles => rawCss(`${Theme.Breakpoints.media["sm"]} { ${styles} }`)
    let md = styles => rawCss(`${Theme.Breakpoints.media["md"]} { ${styles} }`)
    let lg = styles => rawCss(`${Theme.Breakpoints.media["lg"]} { ${styles} }`)
    let xl = styles => rawCss(`${Theme.Breakpoints.media["xl"]} { ${styles} }`)
    let xl2 = styles => rawCss(`${Theme.Breakpoints.media["2xl"]} { ${styles} }`)
  }

  // Color utilities with semantic naming
  module Color = {
    let primary = Theme.Colors.brand["primary"]
    let primaryLight = Theme.Colors.brand["primary-light"]
    let primaryDark = Theme.Colors.brand["primary-dark"]
    let secondary = Theme.Colors.brand["secondary"]

    let success = Theme.Colors.semantic["success"]
    let warning = Theme.Colors.semantic["warning"]
    let error = Theme.Colors.semantic["error"]
    let info = Theme.Colors.semantic["info"]

    let textPrimary = Theme.Colors.text["primary"]
    let textSecondary = Theme.Colors.text["secondary"]
    let textDisabled = Theme.Colors.text["disabled"]

    let bgPrimary = Theme.Colors.background["primary"]
    let bgSecondary = Theme.Colors.background["secondary"]
    let bgElevated = Theme.Colors.background["elevated"]
  }

  // Typography utilities
  module Text = {
    let xs = css({"fontSize": Theme.Typography.fontSize["xs"]})
    let sm = css({"fontSize": Theme.Typography.fontSize["sm"]})
    let base = css({"fontSize": Theme.Typography.fontSize["base"]})
    let lg = css({"fontSize": Theme.Typography.fontSize["lg"]})
    let xl = css({"fontSize": Theme.Typography.fontSize["xl"]})
    let xl2 = css({"fontSize": Theme.Typography.fontSize["2xl"]})
    let xl3 = css({"fontSize": Theme.Typography.fontSize["3xl"]})

    let thin = css({"fontWeight": Theme.Typography.fontWeight["thin"]})
    let light = css({"fontWeight": Theme.Typography.fontWeight["light"]})
    let normal = css({"fontWeight": Theme.Typography.fontWeight["normal"]})
    let medium = css({"fontWeight": Theme.Typography.fontWeight["medium"]})
    let semibold = css({"fontWeight": Theme.Typography.fontWeight["semibold"]})
    let bold = css({"fontWeight": Theme.Typography.fontWeight["bold"]})

    let leading = (~tight=false, ~loose=false, ()) => {
      if tight { css({"lineHeight": Theme.Typography.lineHeight["tight"]}) }
      else if loose { css({"lineHeight": Theme.Typography.lineHeight["loose"]}) }
      else { css({"lineHeight": Theme.Typography.lineHeight["normal"]}) }
    }

    let fontSans = css({"fontFamily": Theme.Typography.fontFamily["sans"]})
    let fontMono = css({"fontFamily": Theme.Typography.fontFamily["mono"]})
  }

  // Spacing utilities - using function approach to avoid dict access issues
  module Space = {
    let getSpacing = (size) => {
      switch size {
      | "0" => "0"
      | "px" => "1px"
      | "0.5" => "0.125rem"
      | "1" => "0.25rem"
      | "1.5" => "0.375rem"
      | "2" => "0.5rem"
      | "2.5" => "0.625rem"
      | "3" => "0.75rem"
      | "3.5" => "0.875rem"
      | "4" => "1rem"
      | "5" => "1.25rem"
      | "6" => "1.5rem"
      | "7" => "1.75rem"
      | "8" => "2rem"
      | "9" => "2.25rem"
      | "10" => "2.5rem"
      | "12" => "3rem"
      | "14" => "3.5rem"
      | "16" => "4rem"
      | "20" => "5rem"
      | "24" => "6rem"
      | "32" => "8rem"
      | "40" => "10rem"
      | "48" => "12rem"
      | "56" => "14rem"
      | "64" => "16rem"
      | _ => "1rem" // default fallback
      }
    }

    // Padding utilities
    let p = (size) => css({"padding": getSpacing(size)})
    let px = (size) => css({"paddingLeft": getSpacing(size), "paddingRight": getSpacing(size)})
    let py = (size) => css({"paddingTop": getSpacing(size), "paddingBottom": getSpacing(size)})
    let pt = (size) => css({"paddingTop": getSpacing(size)})
    let pr = (size) => css({"paddingRight": getSpacing(size)})
    let pb = (size) => css({"paddingBottom": getSpacing(size)})
    let pl = (size) => css({"paddingLeft": getSpacing(size)})

    // Margin utilities
    let m = (size) => css({"margin": getSpacing(size)})
    let mx = (size) => css({"marginLeft": getSpacing(size), "marginRight": getSpacing(size)})
    let my = (size) => css({"marginTop": getSpacing(size), "marginBottom": getSpacing(size)})
    let mt = (size) => css({"marginTop": getSpacing(size)})
    let mr = (size) => css({"marginRight": getSpacing(size)})
    let mb = (size) => css({"marginBottom": getSpacing(size)})
    let ml = (size) => css({"marginLeft": getSpacing(size)})
  }

  // Layout utilities
  module Layout = {
    let flexCenter = css({
      "display": "flex",
      "alignItems": "center",
      "justifyContent": "center"
    })

    let flexBetween = css({
      "display": "flex",
      "alignItems": "center",
      "justifyContent": "space-between"
    })

    let flexCol = css({
      "display": "flex",
      "flexDirection": "column"
    })

    let grid = (~cols=?, ~gap=?, ()) => {
      switch (gap, cols) {
      | (Some(g), Some(c)) => css({
          "display": "grid",
          "gap": Space.getSpacing(g),
          "gridTemplateColumns": `repeat(${string_of_int(c)}, 1fr)`
        })
      | (Some(g), None) => css({
          "display": "grid",
          "gap": Space.getSpacing(g)
        })
      | (None, Some(c)) => css({
          "display": "grid",
          "gridTemplateColumns": `repeat(${string_of_int(c)}, 1fr)`
        })
      | (None, None) => css({"display": "grid"})
      }
    }

    let container = (~maxWidth=?, ()) => {
      let maxW = switch maxWidth {
      | Some(w) => w
      | None => "1280px"
      }

      css({
        "margin": "0 auto",
        "padding": `0 ${Space.getSpacing("4")}`,
        "maxWidth": maxW
      })
    }
  }

  // Border utilities
  module Border = {
    let getRadius = (size) => {
      switch size {
      | "none" => "0"
      | "sm" => "0.125rem"
      | "base" => "0.25rem"
      | "md" => "0.375rem"
      | "lg" => "0.5rem"
      | "xl" => "0.75rem"
      | "2xl" => "1rem"
      | "3xl" => "1.5rem"
      | "full" => "9999px"
      | _ => "0.25rem" // default
      }
    }

    let getBorderWidth = (width) => {
      switch width {
      | "0" => "0"
      | "1" => "1px"
      | "2" => "2px"
      | "4" => "4px"
      | "8" => "8px"
      | _ => "1px" // default
      }
    }

    let rounded = (~size="base", ()) => css({"borderRadius": getRadius(size)})
    let border = (~width="1", ~color="#e5e7eb", ()) =>
      css({"border": `${getBorderWidth(width)} solid ${color}`})
  }

  // Shadow utilities
  module Shadow = {
    let getShadow = (level) => {
      switch level {
      | "none" => "none"
      | "sm" => "0 1px 2px 0 rgb(0 0 0 / 0.05)"
      | "base" => "0 1px 3px 0 rgb(0 0 0 / 0.1), 0 1px 2px -1px rgb(0 0 0 / 0.1)"
      | "md" => "0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1)"
      | "lg" => "0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1)"
      | "xl" => "0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1)"
      | "2xl" => "0 25px 50px -12px rgb(0 0 0 / 0.25)"
      | _ => "none"
      }
    }

    let getFocusShadow = (color) => {
      switch color {
      | "primary" => "0 0 0 3px rgba(100, 108, 255, 0.1)"
      | "success" => "0 0 0 3px rgba(34, 197, 94, 0.1)"
      | "warning" => "0 0 0 3px rgba(245, 158, 11, 0.1)"
      | "error" => "0 0 0 3px rgba(239, 68, 68, 0.1)"
      | _ => "0 0 0 3px rgba(100, 108, 255, 0.1)"
      }
    }

    let sm = css({"boxShadow": getShadow("sm")})
    let base = css({"boxShadow": getShadow("base")})
    let md = css({"boxShadow": getShadow("md")})
    let lg = css({"boxShadow": getShadow("lg")})
    let xl = css({"boxShadow": getShadow("xl")})
    let xl2 = css({"boxShadow": getShadow("2xl")})

    let focus = (~color="primary", ()) => css({"boxShadow": getFocusShadow(color)})
  }

  // Animation utilities
  module Animate = {
    let getDuration = (duration) => {
      switch duration {
      | "fastest" => "150ms"
      | "fast" => "200ms"
      | "normal" => "300ms"
      | "slow" => "500ms"
      | "slowest" => "800ms"
      | _ => "300ms"
      }
    }

    let getEasing = (easing) => {
      switch easing {
      | "linear" => "linear"
      | "ease" => "ease"
      | "ease-in" => "ease-in"
      | "ease-out" => "ease-out"
      | "ease-in-out" => "ease-in-out"
      | "bounce" => "cubic-bezier(0.68, -0.55, 0.265, 1.55)"
      | _ => "ease-out"
      }
    }

    let transition = (~duration="normal", ~property="all", ~easing="ease-out", ()) =>
      css({"transition": `${property} ${getDuration(duration)} ${getEasing(easing)}`})

    // Animation presets - defined inline to avoid module dependency issues
    let fadeIn = css({
      "animation": "fadeIn 300ms ease-out"
    })

    let slideUp = css({
      "animation": "slideUp 300ms ease-out"
    })
  }
}

// Animation presets
module Animations = {
  open Css

  let fadeIn = keyframes({
    "from": {"opacity": 0},
    "to": {"opacity": 1}
  })

  let fadeOut = keyframes({
    "from": {"opacity": 1},
    "to": {"opacity": 0}
  })

  let slideInLeft = keyframes({
    "from": {"transform": "translateX(-100%)"},
    "to": {"transform": "translateX(0)"}
  })

  let slideInRight = keyframes({
    "from": {"transform": "translateX(100%)"},
    "to": {"transform": "translateX(0)"}
  })

  let slideUp = keyframes({
    "from": {"transform": "translateY(100%)"},
    "to": {"transform": "translateY(0)"}
  })

  let spin = keyframes({
    "from": {"transform": "rotate(0deg)"},
    "to": {"transform": "rotate(360deg)"}
  })

  let pulse = keyframes({
    "0%": {"transform": "scale(1)"},
    "50%": {"transform": "scale(1.05)"},
    "100%": {"transform": "scale(1)"}
  })
}

// If you add @emotion/styled, uncomment and use:
/*
module Styled = {
  @module("@emotion/styled") external styled: 'a => 'a = "default"
  // Example: let Div = styled("div")
}
*/

// If you add @emotion/react, uncomment and use:
/*
module React = {
  @module("@emotion/react") external css: {..} => {..} = "css"
  @module("@emotion/react") external keyframes: {..} => string = "keyframes"
  @module("@emotion/react") external Global: {..} => React.element = "Global"
  @module("@emotion/react") external ThemeProvider: {..} => React.element = "ThemeProvider"
}
*/
