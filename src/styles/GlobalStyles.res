// Simplified global styles for initial implementation
open Emotion.Css

let injectGlobalStyles = () => {
  injectGlobal(`
    /* CSS Reset and Global Styles */
    *, *::before, *::after {
      box-sizing: border-box;
    }

    * {
      margin: 0;
    }

    html {
      scroll-behavior: smooth;
    }

    body {
      font-family: Inter, Avenir, Helvetica, Arial, sans-serif;
      font-size: 1rem;
      font-weight: 400;
      line-height: 1.5;
      color: rgba(255, 255, 255, 0.87);
      background-color: #242424;
      min-height: 100vh;
      -webkit-font-smoothing: antialiased;
      -moz-osx-font-smoothing: grayscale;
    }

    /* Typography Elements */
    h1, h2, h3, h4, h5, h6 {
      color: rgba(255, 255, 255, 0.87);
      font-weight: 600;
      line-height: 1.25;
      margin-bottom: 1rem;
    }

    h1 { font-size: 2.25rem; font-weight: 700; }
    h2 { font-size: 1.875rem; }
    h3 { font-size: 1.5rem; }
    h4 { font-size: 1.25rem; }
    h5 { font-size: 1.125rem; }
    h6 { font-size: 1rem; font-weight: 500; }

    p {
      margin-bottom: 1rem;
      color: rgba(255, 255, 255, 0.87);
    }

    /* Link Styles */
    a {
      color: #646cff;
      text-decoration: none;
      font-weight: 500;
      transition: color 200ms ease-out;
    }

    a:hover {
      color: #818cf8;
      text-decoration: underline;
    }

    a:focus {
      outline: 2px solid #646cff;
      outline-offset: 2px;
      border-radius: 0.125rem;
    }

    /* Code Elements */
    code {
      font-family: 'Fira Code', Monaco, 'Cascadia Code', monospace;
      font-size: 0.875em;
      background-color: #2d2d2d;
      padding: 0.25rem 0.5rem;
      border-radius: 0.125rem;
      border: 1px solid #374151;
    }

    pre {
      font-family: 'Fira Code', Monaco, 'Cascadia Code', monospace;
      background-color: #2d2d2d;
      padding: 1rem;
      border-radius: 0.375rem;
      border: 1px solid #374151;
      overflow-x: auto;
      margin-bottom: 1rem;
    }

    pre code {
      background: none;
      padding: 0;
      border: none;
    }

    /* Form Elements */
    input, textarea, select, button {
      font-family: inherit;
      font-size: inherit;
    }

    button {
      cursor: pointer;
      border: none;
      background: none;
      padding: 0;
    }

    input, textarea, select {
      background-color: #1a1a1a;
      border: 1px solid #374151;
      border-radius: 0.375rem;
      padding: 0.5rem 0.75rem;
      color: rgba(255, 255, 255, 0.87);
      transition: all 200ms ease-out;
    }

    input:focus, textarea:focus, select:focus {
      outline: none;
      border-color: #646cff;
      box-shadow: 0 0 0 3px rgba(100, 108, 255, 0.1);
    }

    input::placeholder, textarea::placeholder {
      color: rgba(255, 255, 255, 0.6);
    }

    /* Utility Classes */
    .sr-only {
      position: absolute;
      width: 1px;
      height: 1px;
      padding: 0;
      margin: -1px;
      overflow: hidden;
      clip: rect(0, 0, 0, 0);
      white-space: nowrap;
      border: 0;
    }

    /* Light theme overrides */
    @media (prefers-color-scheme: light) {
      body {
        color: #213547;
        background-color: #ffffff;
      }

      h1, h2, h3, h4, h5, h6, p {
        color: #213547;
      }

      a:hover {
        color: #4338ca;
      }

      code {
        background-color: #f3f4f6;
        border-color: #e5e7eb;
      }

      pre {
        background-color: #f9fafb;
        border-color: #e5e7eb;
      }

      input, textarea, select {
        background-color: #ffffff;
        border-color: #d1d5db;
        color: #213547;
      }

      input::placeholder, textarea::placeholder {
        color: #6b7280;
      }
    }

    /* Reduced Motion */
    @media (prefers-reduced-motion: reduce) {
      *, *::before, *::after {
        animation-duration: 0.01ms !important;
        animation-iteration-count: 1 !important;
        transition-duration: 0.01ms !important;
        scroll-behavior: auto !important;
      }
    }
  `)
}

// Call this function to inject the global styles
let initialize = injectGlobalStyles