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
      font-size: 1.0625rem;
      font-weight: 400;
      line-height: 1.75;
      color: #ece4d8;
      background-color: #1a1816;
      min-height: 100vh;
      -webkit-font-smoothing: antialiased;
      -moz-osx-font-smoothing: grayscale;
    }

    /* Typography Elements */
    h1, h2, h3, h4, h5, h6 {
      font-family: 'Playfair Display', Georgia, 'Times New Roman', serif;
      color: #ece4d8;
      font-weight: 400;
      line-height: 1.2;
      letter-spacing: -0.02em;
      margin-bottom: 1rem;
    }

    h1 { font-size: 2.5rem; }
    h2 { font-size: 2rem; }
    h3 { font-size: 1.5rem; }
    h4 { font-size: 1.25rem; }
    h5 { font-size: 1.125rem; }
    h6 { font-size: 1rem; }

    p {
      margin-bottom: 1rem;
      color: #ece4d8;
    }

    /* Link Styles */
    a {
      color: #c8a45c;
      text-decoration: none;
      font-weight: 500;
      transition: color 200ms ease-out;
    }

    a:hover {
      color: #dfc088;
      text-decoration: underline;
      text-underline-offset: 3px;
    }

    a:focus {
      outline: 2px solid #c8a45c;
      outline-offset: 2px;
      border-radius: 0.125rem;
    }

    /* Code Elements */
    code {
      font-family: 'Fira Code', Monaco, 'Cascadia Code', monospace;
      font-size: 0.875em;
      background-color: #242120;
      padding: 0.25rem 0.5rem;
      border-radius: 0.125rem;
      border: 1px solid #33302c;
    }

    pre {
      font-family: 'Fira Code', Monaco, 'Cascadia Code', monospace;
      background-color: #242120;
      padding: 1rem;
      border-radius: 0.375rem;
      border: 1px solid #33302c;
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
      background-color: #141210;
      border: 1px solid #33302c;
      border-radius: 0.375rem;
      padding: 0.5rem 0.75rem;
      color: #ece4d8;
      transition: all 200ms ease-out;
    }

    input:focus, textarea:focus, select:focus {
      outline: none;
      border-color: #c8a45c;
      box-shadow: 0 0 0 3px rgba(200, 164, 92, 0.25);
    }

    input::placeholder, textarea::placeholder {
      color: #7a7268;
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