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
        "backgroundColor": "#646cff",
        "color": "white",
        ":hover": {
          "backgroundColor": "#4f46e5"
        },
        ":focus": {
          "boxShadow": "0 0 0 3px rgba(100, 108, 255, 0.1)"
        },
        ":active": {
          "backgroundColor": "#4f46e5",
          "transform": "translateY(1px)"
        }
      })
    | #secondary => css({
        "backgroundColor": "#e5e7eb",
        "color": "#374151",
        ":hover": {
          "backgroundColor": "#d1d5db"
        },
        ":focus": {
          "boxShadow": "0 0 0 2px rgba(156, 163, 175, 0.5)"
        }
      })
    | #outline => css({
        "backgroundColor": "transparent",
        "color": "#646cff",
        "border": "1px solid #646cff",
        ":hover": {
          "backgroundColor": "#646cff",
          "color": "white"
        },
        ":focus": {
          "boxShadow": "0 0 0 3px rgba(100, 108, 255, 0.1)"
        }
      })
    | #ghost => css({
        "backgroundColor": "transparent",
        "color": "#646cff",
        ":hover": {
          "backgroundColor": "#f3f4f6"
        },
        ":focus": {
          "boxShadow": "0 0 0 3px rgba(100, 108, 255, 0.1)"
        }
      })
    | #danger => css({
        "backgroundColor": "#ef4444",
        "color": "white",
        ":hover": {
          "backgroundColor": "#dc2626"
        },
        ":focus": {
          "boxShadow": "0 0 0 3px rgba(239, 68, 68, 0.1)"
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
    "border": "1px solid #d1d5db",
    "borderRadius": "0.375rem",
    "fontSize": "1rem",
    "fontFamily": "inherit",
    "color": "#374151",
    "backgroundColor": "#ffffff",
    "transition": "all 200ms ease-out",
    "outline": "none",
    ":focus": {
      "borderColor": "#646cff",
      "boxShadow": "0 0 0 3px rgba(100, 108, 255, 0.1)"
    },
    "::placeholder": {
      "color": "#9ca3af"
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
          "boxShadow": "0 0 0 3px rgba(239, 68, 68, 0.1)"
        }
      })
    | #success => css({
        "borderColor": "#22c55e",
        ":focus": {
          "borderColor": "#22c55e",
          "boxShadow": "0 0 0 3px rgba(34, 197, 94, 0.1)"
        }
      })
    }
  }

  let disabled = css({
    "opacity": "0.6",
    "cursor": "not-allowed",
    "backgroundColor": "#f9fafb"
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
        "backgroundColor": "#ffffff",
        "boxShadow": "0 4px 6px -1px rgb(0 0 0 / 0.1)",
        ":hover": {
          "boxShadow": "0 10px 15px -3px rgb(0 0 0 / 0.1)"
        }
      })
    | #outlined => css({
        "backgroundColor": "#ffffff",
        "border": "1px solid #e5e7eb",
        ":hover": {
          "borderColor": "#d1d5db"
        }
      })
    | #filled => css({
        "backgroundColor": "#f9fafb"
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
      "color": "#374151",
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
    | Some("secondary") => "#6b7280"
    | Some("disabled") => "#9ca3af"
    | Some(custom) => custom
    | None => "#374151"
    }

    css({
      "fontSize": fontSize,
      "fontWeight": fontWeight,
      "color": textColor,
      "lineHeight": "1.5"
    })
  }
}