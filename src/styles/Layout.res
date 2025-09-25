// Simplified layout utilities for initial implementation
open Emotion.Css

module Layout = {
  // Container utilities
  let container = (~maxWidth=?, ~padding=?, ()) => {
    let paddingValue = switch padding {
    | Some("sm") => "0 1rem"
    | Some("md") => "0 1.5rem"
    | Some("lg") => "0 2rem"
    | Some(_) | None => "0 1rem"
    }

    let maxWidthValue = switch maxWidth {
    | Some("sm") => "640px"
    | Some("md") => "768px"
    | Some("lg") => "1024px"
    | Some("xl") => "1280px"
    | Some("2xl") => "1536px"
    | Some("full") => "100%"
    | Some(custom) => custom
    | None => "1280px"
    }

    css({
      "margin": "0 auto",
      "padding": paddingValue,
      "maxWidth": maxWidthValue
    })
  }

  // Section utilities
  let section = (~spacing="4rem", ~background=?, ()) => {
    switch background {
    | Some(bg) => css({
        "padding": `${spacing} 0`,
        "backgroundColor": bg
      })
    | None => css({
        "padding": `${spacing} 0`
      })
    }
  }

  // Flexbox utilities
  module Flex = {
    let base = css({"display": "flex"})

    let center = css({
      "display": "flex",
      "alignItems": "center",
      "justifyContent": "center"
    })

    let between = css({
      "display": "flex",
      "alignItems": "center",
      "justifyContent": "space-between"
    })

    let around = css({
      "display": "flex",
      "alignItems": "center",
      "justifyContent": "space-around"
    })

    let start = css({
      "display": "flex",
      "alignItems": "flex-start",
      "justifyContent": "flex-start"
    })

    let end = css({
      "display": "flex",
      "alignItems": "flex-end",
      "justifyContent": "flex-end"
    })

    let col = css({
      "display": "flex",
      "flexDirection": "column"
    })

    let colCenter = css({
      "display": "flex",
      "flexDirection": "column",
      "alignItems": "center",
      "justifyContent": "center"
    })

    let wrap = css({"flexWrap": "wrap"})

    let gap = (size) => {
      let gapValue = switch size {
      | "1" => "0.25rem"
      | "2" => "0.5rem"
      | "3" => "0.75rem"
      | "4" => "1rem"
      | "5" => "1.25rem"
      | "6" => "1.5rem"
      | "8" => "2rem"
      | _ => "1rem"
      }
      css({"gap": gapValue})
    }

    // Flex item utilities
    let flex1 = css({"flex": "1"})
    let flexShrink0 = css({"flexShrink": "0"})
    let flexGrow1 = css({"flexGrow": "1"})
  }

  // Grid utilities
  module Grid = {
    let base = css({"display": "grid"})

    let cols = (count) => css({
      "display": "grid",
      "gridTemplateColumns": `repeat(${string_of_int(count)}, 1fr)`
    })

    let gap = (size) => {
      let gapValue = switch size {
      | "1" => "0.25rem"
      | "2" => "0.5rem"
      | "3" => "0.75rem"
      | "4" => "1rem"
      | "5" => "1.25rem"
      | "6" => "1.5rem"
      | "8" => "2rem"
      | _ => "1rem"
      }
      css({"gap": gapValue})
    }

    let colGap = (size) => {
      let gapValue = switch size {
      | "1" => "0.25rem"
      | "2" => "0.5rem"
      | "3" => "0.75rem"
      | "4" => "1rem"
      | "5" => "1.25rem"
      | "6" => "1.5rem"
      | "8" => "2rem"
      | _ => "1rem"
      }
      css({"columnGap": gapValue})
    }

    let rowGap = (size) => {
      let gapValue = switch size {
      | "1" => "0.25rem"
      | "2" => "0.5rem"
      | "3" => "0.75rem"
      | "4" => "1rem"
      | "5" => "1.25rem"
      | "6" => "1.5rem"
      | "8" => "2rem"
      | _ => "1rem"
      }
      css({"rowGap": gapValue})
    }

    // Grid item utilities
    let colSpan = (count) => css({"gridColumn": `span ${string_of_int(count)}`})
    let rowSpan = (count) => css({"gridRow": `span ${string_of_int(count)}`})
  }

  // Stack utilities (for consistent vertical/horizontal spacing)
  module Stack = {
    let vertical = (~gap="4", ~align=?, ()) => {
      let gapValue = switch gap {
      | "1" => "0.25rem"
      | "2" => "0.5rem"
      | "3" => "0.75rem"
      | "4" => "1rem"
      | "5" => "1.25rem"
      | "6" => "1.5rem"
      | "8" => "2rem"
      | _ => "1rem"
      }

      let alignValue = switch align {
      | Some("center") => "center"
      | Some("start") => "flex-start"
      | Some("end") => "flex-end"
      | Some("stretch") => "stretch"
      | Some(_) | None => "stretch"
      }

      css({
        "display": "flex",
        "flexDirection": "column",
        "gap": gapValue,
        "alignItems": alignValue
      })
    }

    let horizontal = (~gap="4", ~align=?, ~justify=?, ()) => {
      let gapValue = switch gap {
      | "1" => "0.25rem"
      | "2" => "0.5rem"
      | "3" => "0.75rem"
      | "4" => "1rem"
      | "5" => "1.25rem"
      | "6" => "1.5rem"
      | "8" => "2rem"
      | _ => "1rem"
      }

      let alignValue = switch align {
      | Some("center") => "center"
      | Some("start") => "flex-start"
      | Some("end") => "flex-end"
      | Some("stretch") => "stretch"
      | Some(_) | None => "center"
      }

      let justifyValue = switch justify {
      | Some("center") => "center"
      | Some("between") => "space-between"
      | Some("around") => "space-around"
      | Some("evenly") => "space-evenly"
      | Some("start") => "flex-start"
      | Some("end") => "flex-end"
      | Some(_) | None => "flex-start"
      }

      css({
        "display": "flex",
        "gap": gapValue,
        "alignItems": alignValue,
        "justifyContent": justifyValue
      })
    }
  }
}