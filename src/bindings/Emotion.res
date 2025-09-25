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

  // Pseudo-class helpers
  let hover = styles => css({":hover": styles})
  let focus = styles => css({":focus": styles})
  let active = styles => css({":active": styles})

  // Common breakpoints (customize as needed) - use in global styles or inline
  // Example: injectGlobal(`@media (max-width: 768px) { .class { font-size: 14px; } }`)
  let mobileQuery = "(max-width: 768px)"
  let tabletQuery = "(min-width: 769px) and (max-width: 1024px)"
  let desktopQuery = "(min-width: 1025px)"

  // Color utilities (example; expand as needed)
  let colors = {
    "primary": "#646cff",
    "secondary": "#535bf2",
    "background": "#242424",
    "text": "rgba(255, 255, 255, 0.87)",
    "success": "#4caf50",
    "warning": "#ff9800",
    "error": "#f44336",
    "info": "#2196f3",
  }

  // Typography scale
  let fontSize = {
    "xs": "0.75rem",
    "sm": "0.875rem",
    "base": "1rem",
    "lg": "1.125rem",
    "xl": "1.25rem",
    "2xl": "1.5rem",
    "3xl": "1.875rem",
    "4xl": "2.25rem",
  }

  // Spacing scale
  let spacing = {
    "0": "0",
    "1": "0.25rem",
    "2": "0.5rem",
    "3": "0.75rem",
    "4": "1rem",
    "5": "1.25rem",
    "6": "1.5rem",
    "8": "2rem",
    "10": "2.5rem",
    "12": "3rem",
    "16": "4rem",
  }

  // Common transitions
  let transition = {
    "fast": "all 0.15s ease",
    "base": "all 0.3s ease",
    "slow": "all 0.5s ease",
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
