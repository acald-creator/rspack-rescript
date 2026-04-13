open Emotion.Css
open Emotion.Utils

module PostsQuery = %relay(`
  query PostsPageQuery {
    posts {
      id
      title
      body
      createdAt
      author {
        name
      }
    }
  }
`)

module PostCard = {
  module Typography = Typography.Typography
  module Card = Card.Card

  @react.component
  let make = (~title, ~body, ~authorName, ~createdAt) => {
    <Card variant=#outlined className={css({"marginBottom": "1rem"})}>
      <Card.Header>
        <Typography.Heading level=#h3 size=#lg> {React.string(title)} </Typography.Heading>
      </Card.Header>
      <Card.Body>
        <Typography.Body> {React.string(body)} </Typography.Body>
        <div
          className={css({
            "display": "flex",
            "justifyContent": "space-between",
            "marginTop": "1rem",
          })}>
          <Typography.Caption> {React.string(authorName)} </Typography.Caption>
          <Typography.Caption> {React.string(createdAt)} </Typography.Caption>
        </div>
      </Card.Body>
    </Card>
  }
}

module PostsList = {
  module Typography = Typography.Typography

  @react.component
  let make = () => {
    let data = PostsQuery.use(~variables=())

    <div>
      {data.posts
      ->Array.map(post => {
        <PostCard
          key={post.id}
          title={post.title}
          body={post.body}
          authorName={post.author.name}
          createdAt={post.createdAt}
        />
      })
      ->React.array}
    </div>
  }
}

module ServerUnavailable = {
  module Typography = Typography.Typography
  module Card = Card.Card

  @react.component
  let make = () => {
    <Card variant=#outlined>
      <Card.Body>
        <Typography.Heading level=#h3>
          {React.string("GraphQL Server Not Running")}
        </Typography.Heading>
        <Typography.Body className={css({"color": Color.textSecondary})}>
          {React.string(
            "The Posts page requires the mock GraphQL server. Start it locally with:",
          )}
        </Typography.Body>
        <code
          className={css({
            "display": "block",
            "padding": "0.75rem 1rem",
            "marginTop": "0.75rem",
            "backgroundColor": Color.bgElevated,
            "borderRadius": "0.375rem",
            "fontSize": "0.875rem",
            "color": Color.primary,
          })}>
          {React.string("bun run dev:server")}
        </code>
      </Card.Body>
    </Card>
  }
}

module Typography = Typography.Typography

@react.component
let make = () => {
  let containerStyles = css({
    "padding": "4rem 1rem",
    "maxWidth": "800px",
    "margin": "0 auto",
  })

  <div className={containerStyles}>
    <Typography.Display size=#"3xl"> {React.string("Posts")} </Typography.Display>
    <Typography.Body
      className={css({"marginTop": "0.5rem", "marginBottom": "2rem", "color": Color.textSecondary})}>
      {React.string("Data fetched from the mock GraphQL server via Relay.")}
    </Typography.Body>
    <RescriptReactErrorBoundary fallback={_ => <ServerUnavailable />}>
      <React.Suspense
        fallback={<Typography.Body> {React.string("Loading posts...")} </Typography.Body>}>
        <PostsList />
      </React.Suspense>
    </RescriptReactErrorBoundary>
  </div>
}
