open Test
open App
open Dom

@get external textContent: Dom.element => string = "textContent"

@module("@testing-library/react")
external act: (@uncurry unit => unit) => unit = "act"

@val external window: {..} = "window"
@send external remove: Dom.element => unit = "remove"

let createContainer = () => {
  let containerElement: Dom.element = window["document"]["createElement"]("div")
  let _ = window["document"]["body"]["appendChild"](containerElement)
  containerElement
}

let cleanupContainer = (container: Dom.element) => {
  ReactDOM.unmountComponentAtNode(container)
  remove(container)
}

let testWithReact = testWith(~setup=createContainer, ~teardown=cleanupContainer)
let testAsyncWithReact = testAsyncWith(~setup=createContainer, ~teardown=cleanupContainer)

testWithReact("Can render", container => {
  act(() => ReactDOM.render(<App />, container))

  let countElement = ReactDOM.querySelector(".count")

  cleanupContainer(container)
})
