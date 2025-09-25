// Comprehensive design system theme tokens
module Theme = {
  // Color System
  module Colors = {
    // Brand Colors
    let brand = {
      "primary": "#646cff",
      "primary-light": "#818cf8",
      "primary-dark": "#4f46e5",
      "secondary": "#535bf2",
      "secondary-light": "#6366f1",
      "secondary-dark": "#4338ca",
    }

    // Semantic Colors
    let semantic = {
      "success": "#22c55e",
      "success-light": "#4ade80",
      "success-dark": "#16a34a",
      "warning": "#f59e0b",
      "warning-light": "#fbbf24",
      "warning-dark": "#d97706",
      "error": "#ef4444",
      "error-light": "#f87171",
      "error-dark": "#dc2626",
      "info": "#3b82f6",
      "info-light": "#60a5fa",
      "info-dark": "#2563eb",
    }

    // Neutral Colors (Light Theme)
    let neutralLight = {
      "50": "#f9fafb",
      "100": "#f3f4f6",
      "200": "#e5e7eb",
      "300": "#d1d5db",
      "400": "#9ca3af",
      "500": "#6b7280",
      "600": "#4b5563",
      "700": "#374151",
      "800": "#1f2937",
      "900": "#111827",
    }

    // Neutral Colors (Dark Theme)
    let neutralDark = {
      "50": "#111827",
      "100": "#1f2937",
      "200": "#374151",
      "300": "#4b5563",
      "400": "#6b7280",
      "500": "#9ca3af",
      "600": "#d1d5db",
      "700": "#e5e7eb",
      "800": "#f3f4f6",
      "900": "#f9fafb",
    }

    // Theme-aware colors
    let text = {
      "primary": "rgba(255, 255, 255, 0.87)",
      "secondary": "rgba(255, 255, 255, 0.6)",
      "disabled": "rgba(255, 255, 255, 0.38)",
      "inverse": "#213547",
    }

    let background = {
      "primary": "#242424",
      "secondary": "#1a1a1a",
      "elevated": "#2d2d2d",
      "overlay": "rgba(0, 0, 0, 0.6)",
      "inverse": "#ffffff",
    }
  }

  // Typography System
  module Typography = {
    let fontFamily = {
      "sans": "Inter, Avenir, Helvetica, Arial, sans-serif",
      "mono": "'Fira Code', 'Monaco', 'Cascadia Code', monospace",
    }

    let fontSize = {
      "xs": "0.75rem",    // 12px
      "sm": "0.875rem",   // 14px
      "base": "1rem",     // 16px
      "lg": "1.125rem",   // 18px
      "xl": "1.25rem",    // 20px
      "2xl": "1.5rem",    // 24px
      "3xl": "1.875rem",  // 30px
      "4xl": "2.25rem",   // 36px
      "5xl": "3rem",      // 48px
      "6xl": "3.75rem",   // 60px
      "7xl": "4.5rem",    // 72px
    }

    let fontWeight = {
      "thin": "100",
      "light": "300",
      "normal": "400",
      "medium": "500",
      "semibold": "600",
      "bold": "700",
      "extrabold": "800",
    }

    let lineHeight = {
      "tight": "1.25",
      "snug": "1.375",
      "normal": "1.5",
      "relaxed": "1.625",
      "loose": "2",
    }

    let letterSpacing = {
      "tight": "-0.025em",
      "normal": "0",
      "wide": "0.025em",
      "wider": "0.05em",
      "widest": "0.1em",
    }
  }

  // Spacing System
  module Spacing = {
    let scale = {
      "0": "0",
      "px": "1px",
      "0.5": "0.125rem",  // 2px
      "1": "0.25rem",     // 4px
      "1.5": "0.375rem",  // 6px
      "2": "0.5rem",      // 8px
      "2.5": "0.625rem",  // 10px
      "3": "0.75rem",     // 12px
      "3.5": "0.875rem",  // 14px
      "4": "1rem",        // 16px
      "5": "1.25rem",     // 20px
      "6": "1.5rem",      // 24px
      "7": "1.75rem",     // 28px
      "8": "2rem",        // 32px
      "9": "2.25rem",     // 36px
      "10": "2.5rem",     // 40px
      "12": "3rem",       // 48px
      "14": "3.5rem",     // 56px
      "16": "4rem",       // 64px
      "20": "5rem",       // 80px
      "24": "6rem",       // 96px
      "32": "8rem",       // 128px
      "40": "10rem",      // 160px
      "48": "12rem",      // 192px
      "56": "14rem",      // 224px
      "64": "16rem",      // 256px
    }
  }

  // Border System
  module Borders = {
    let radius = {
      "none": "0",
      "sm": "0.125rem",   // 2px
      "base": "0.25rem",  // 4px
      "md": "0.375rem",   // 6px
      "lg": "0.5rem",     // 8px
      "xl": "0.75rem",    // 12px
      "2xl": "1rem",      // 16px
      "3xl": "1.5rem",    // 24px
      "full": "9999px",
    }

    let width = {
      "0": "0",
      "1": "1px",
      "2": "2px",
      "4": "4px",
      "8": "8px",
    }
  }

  // Shadow System
  module Shadows = {
    let elevation = {
      "none": "none",
      "sm": "0 1px 2px 0 rgb(0 0 0 / 0.05)",
      "base": "0 1px 3px 0 rgb(0 0 0 / 0.1), 0 1px 2px -1px rgb(0 0 0 / 0.1)",
      "md": "0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1)",
      "lg": "0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1)",
      "xl": "0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1)",
      "2xl": "0 25px 50px -12px rgb(0 0 0 / 0.25)",
    }

    let colored = {
      "primary": "0 0 0 3px rgba(100, 108, 255, 0.1)",
      "success": "0 0 0 3px rgba(34, 197, 94, 0.1)",
      "warning": "0 0 0 3px rgba(245, 158, 11, 0.1)",
      "error": "0 0 0 3px rgba(239, 68, 68, 0.1)",
    }
  }

  // Animation System
  module Animations = {
    let duration = {
      "fastest": "150ms",
      "fast": "200ms",
      "normal": "300ms",
      "slow": "500ms",
      "slowest": "800ms",
    }

    let easing = {
      "linear": "linear",
      "ease": "ease",
      "ease-in": "ease-in",
      "ease-out": "ease-out",
      "ease-in-out": "ease-in-out",
      "bounce": "cubic-bezier(0.68, -0.55, 0.265, 1.55)",
    }

    let transition = {
      "fast": "all 150ms ease-out",
      "normal": "all 300ms ease-out",
      "slow": "all 500ms ease-out",
      "colors": "background-color 200ms ease-out, border-color 200ms ease-out, color 200ms ease-out",
      "transform": "transform 200ms ease-out",
      "opacity": "opacity 200ms ease-out",
    }
  }

  // Breakpoints
  module Breakpoints = {
    let values = {
      "sm": "640px",
      "md": "768px",
      "lg": "1024px",
      "xl": "1280px",
      "2xl": "1536px",
    }

    let media = {
      "sm": `@media (min-width: ${values["sm"]})`,
      "md": `@media (min-width: ${values["md"]})`,
      "lg": `@media (min-width: ${values["lg"]})`,
      "xl": `@media (min-width: ${values["xl"]})`,
      "2xl": `@media (min-width: ${values["2xl"]})`,
    }
  }

  // Z-Index Scale
  module ZIndex = {
    let scale = {
      "hide": "-1",
      "auto": "auto",
      "base": "0",
      "docked": "10",
      "dropdown": "1000",
      "sticky": "1100",
      "banner": "1200",
      "overlay": "1300",
      "modal": "1400",
      "popover": "1500",
      "tooltip": "1600",
    }
  }

  // Component-specific tokens
  module Components = {
    let button = {
      "height": {
        "sm": "2rem",
        "md": "2.5rem",
        "lg": "3rem",
        "xl": "3.5rem",
      },
      "padding": {
        "sm": "0.5rem 0.75rem",
        "md": "0.625rem 1rem",
        "lg": "0.75rem 1.25rem",
        "xl": "0.875rem 1.5rem",
      }
    }

    let input = {
      "height": {
        "sm": "2rem",
        "md": "2.5rem",
        "lg": "3rem",
      },
      "padding": "0.5rem 0.75rem",
    }
  }
}