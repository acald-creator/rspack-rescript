module Css = {
  @module("@emotion/css") external css: {..} => string = "css"
  @module("@emotion/css") external rawCss: string => string = "css"
  @module("@emotion/css") external keyframes: {..} => string = "css"
  @module("@emotion/css") external cx: array<string> => string = "cx"
  @module("@emotion/css") external injectGlobal: string => unit = "injectGlobal"
}

module Server = {
  @module("@emotion/server")
  external renderStylesToString: string => string = "renderStylesToString"
}
