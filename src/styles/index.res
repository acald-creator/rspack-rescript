// Export all design system modules for easy import
module Theme = Theme
module GlobalStyles = GlobalStyles
module Layout = Layout
module Components = Components

// Initialize the design system
let initialize = () => {
  GlobalStyles.initialize()
}

// Re-export commonly used utilities from Emotion.Utils
open Emotion.Utils

module Colors = Color
module Text = Text
module Space = Space
module Responsive = Responsive
module Shadow = Shadow
module Border = Border
module Animate = Animate