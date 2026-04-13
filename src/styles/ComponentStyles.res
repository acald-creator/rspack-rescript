// Simplified component base styles for initial implementation
open Emotion.Css

// Button Component Styles
module Button = {
  type variant = [#primary | #secondary | #outline | #ghost | #danger]
  type size = [#xs | #sm | #md | #lg | #xl]

  let base = css({
    "display": "inline-flex",
    "alignItems": "center",
    "justifyContent": "center",
    "borderRadius": "0.375rem",
    "border": "none",
    "cursor": "pointer",
    "fontFamily": "inherit",
    "fontWeight": "500",
    "textDecoration": "none",
    "transition": "all 200ms ease-out",
    "userSelect": "none",
    "whiteSpace": "nowrap",
    "position": "relative",
    "overflow": "hidden"
  })

  let size = (size: size) => {
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

  let variant = (variant: variant) => {
    switch variant {
    | #primary => css({
        "backgroundColor": "#c8a45c",
        "color": "#1a1816",
        ":hover": {
          "backgroundColor": "#a88540"
        },
        ":focus": {
          "boxShadow": "0 0 0 3px rgba(200, 164, 92, 0.25)"
        },
        ":active": {
          "backgroundColor": "#a88540",
          "transform": "translateY(1px)"
        }
      })
    | #secondary => css({
        "backgroundColor": "#33302c",
        "color": "#ece4d8",
        ":hover": {
          "backgroundColor": "#3d3935"
        },
        ":focus": {
          "boxShadow": "0 0 0 2px rgba(200, 164, 92, 0.2)"
        }
      })
    | #outline => css({
        "backgroundColor": "transparent",
        "color": "#c8a45c",
        "border": "1px solid #c8a45c",
        ":hover": {
          "backgroundColor": "#c8a45c",
          "color": "#1a1816"
        },
        ":focus": {
          "boxShadow": "0 0 0 3px rgba(200, 164, 92, 0.25)"
        }
      })
    | #ghost => css({
        "backgroundColor": "transparent",
        "color": "#c8a45c",
        ":hover": {
          "backgroundColor": "rgba(200, 164, 92, 0.08)"
        },
        ":focus": {
          "boxShadow": "0 0 0 3px rgba(200, 164, 92, 0.25)"
        }
      })
    | #danger => css({
        "backgroundColor": "#ef4444",
        "color": "white",
        ":hover": {
          "backgroundColor": "#b91c1c"
        },
        ":focus": {
          "boxShadow": "0 0 0 3px rgba(239, 68, 68, 0.25)"
        }
      })
    }
  }

  let disabled = css({
    "opacity": "0.5",
    "cursor": "not-allowed",
    "pointerEvents": "none"
  })

  let loading = css({
    "color": "transparent",
    "position": "relative",
    "pointerEvents": "none"
  })

  let fullWidth = css({
    "width": "100%"
  })
}

// Input Component Styles
module Input = {
  type size = [#sm | #md | #lg]
  type state = [#default | #error | #success]

  let base = css({
    "width": "100%",
    "border": "1px solid #33302c",
    "borderRadius": "0.375rem",
    "fontSize": "1rem",
    "fontFamily": "inherit",
    "color": "#ece4d8",
    "backgroundColor": "#141210",
    "transition": "all 200ms ease-out",
    "outline": "none",
    ":focus": {
      "borderColor": "#c8a45c",
      "boxShadow": "0 0 0 3px rgba(200, 164, 92, 0.25)"
    },
    "::placeholder": {
      "color": "#5c564e"
    }
  })

  let size = (size: size) => {
    switch size {
    | #sm => css({
        "height": "2rem",
        "padding": "0 0.75rem",
        "fontSize": "0.875rem"
      })
    | #md => css({
        "height": "2.5rem",
        "padding": "0.5rem 0.75rem",
        "fontSize": "1rem"
      })
    | #lg => css({
        "height": "3rem",
        "padding": "0 1rem",
        "fontSize": "1.125rem"
      })
    }
  }

  let state = (state: state) => {
    switch state {
    | #default => css({"border": "inherit"})
    | #error => css({
        "borderColor": "#ef4444",
        ":focus": {
          "borderColor": "#ef4444",
          "boxShadow": "0 0 0 3px rgba(239, 68, 68, 0.25)"
        }
      })
    | #success => css({
        "borderColor": "#22c55e",
        ":focus": {
          "borderColor": "#22c55e",
          "boxShadow": "0 0 0 3px rgba(34, 197, 94, 0.25)"
        }
      })
    }
  }

  let disabled = css({
    "opacity": "0.6",
    "cursor": "not-allowed",
    "backgroundColor": "#1a1816"
  })
}

// Card Component Styles
module Card = {
  type variant = [#elevated | #outlined | #filled]

  let base = css({
    "borderRadius": "0.5rem",
    "overflow": "hidden",
    "transition": "all 300ms ease-out"
  })

  let variant = (variant: variant) => {
    switch variant {
    | #elevated => css({
        "backgroundColor": "#242120",
        "boxShadow": "0 4px 6px -1px rgb(0 0 0 / 0.3)",
        ":hover": {
          "boxShadow": "0 10px 15px -3px rgb(0 0 0 / 0.3)"
        }
      })
    | #outlined => css({
        "backgroundColor": "#1a1816",
        "border": "1px solid #33302c",
        ":hover": {
          "borderColor": "#3d3935"
        }
      })
    | #filled => css({
        "backgroundColor": "#242120"
      })
    }
  }

  let padding = (size) => {
    switch size {
    | "sm" => css({"padding": "1rem"})
    | "md" => css({"padding": "1.5rem"})
    | "lg" => css({"padding": "2rem"})
    | _ => css({"padding": "1.5rem"})
    }
  }

  let clickable = css({
    "cursor": "pointer",
    "transition": "transform 200ms ease-out",
    ":hover": {
      "transform": "translateY(-2px)"
    },
    ":active": {
      "transform": "translateY(0)"
    }
  })
}

// Typography Component Styles
module Typography = {
  let heading = (~level=1, ~weight=?, ()) => {
    let fontSize = switch level {
    | 1 => "2.25rem"
    | 2 => "1.875rem"
    | 3 => "1.5rem"
    | 4 => "1.25rem"
    | 5 => "1.125rem"
    | 6 => "1rem"
    | _ => "1rem"
    }

    let fontWeight = switch weight {
    | Some(w) => w
    | None when level <= 2 => "700"
    | None => "600"
    }

    css({
      "fontSize": fontSize,
      "fontWeight": fontWeight,
      "lineHeight": "1.25",
      "color": "#ece4d8",
      "marginBottom": "1rem"
    })
  }

  let text = (~size="base", ~weight="normal", ~color=?, ()) => {
    let fontSize = switch size {
    | "xs" => "0.75rem"
    | "sm" => "0.875rem"
    | "base" => "1rem"
    | "lg" => "1.125rem"
    | "xl" => "1.25rem"
    | _ => "1rem"
    }

    let fontWeight = switch weight {
    | "light" => "300"
    | "normal" => "400"
    | "medium" => "500"
    | "semibold" => "600"
    | "bold" => "700"
    | _ => "400"
    }

    let textColor = switch color {
    | Some("secondary") => "#9a9084"
    | Some("disabled") => "#5c564e"
    | Some(custom) => custom
    | None => "#ece4d8"
    }

    css({
      "fontSize": fontSize,
      "fontWeight": fontWeight,
      "color": textColor,
      "lineHeight": "1.5"
    })
  }
}
