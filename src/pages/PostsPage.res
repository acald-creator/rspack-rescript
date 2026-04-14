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

module PostItem = {
  module Typography = Typography.Typography

  @react.component
  let make = (~title, ~body, ~authorName, ~createdAt) => {
    let itemStyles = css({
      "borderBottom": `1px solid ${Color.border}`,
      "paddingBottom": "2rem",
      "marginBottom": "2rem",
    })

    let metaStyles = css({
      "display": "flex",
      "gap": "0.5rem",
      "alignItems": "center",
      "marginBottom": "0.75rem",
    })

    let dotStyles = css({
      "color": Color.textSecondary,
      "fontSize": "0.75rem",
    })

    <article className={itemStyles}>
      <div className={metaStyles}>
        <Typography.Overline> {React.string(authorName)} </Typography.Overline>
        <span className={dotStyles}> {React.string({`\u00B7`})} </span>
        <Typography.Overline> {React.string(createdAt)} </Typography.Overline>
      </div>
      <Typography.Heading level=#h2 size=#"2xl">
        {React.string(title)}
      </Typography.Heading>
      <Typography.Body className={css({"color": Color.textSecondary, "margin": "0"})}>
        {React.string(body)}
      </Typography.Body>
    </article>
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
        <PostItem
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

  @react.component
  let make = () => {
    let containerStyles = css({
      "borderTop": `2px solid ${Color.primary}`,
      "padding": "2rem 0",
    })

    <div className={containerStyles}>
      <Typography.Heading level=#h3>
        {React.string("GraphQL Server Not Running")}
      </Typography.Heading>
      <Typography.Body className={css({"color": Color.textSecondary})}>
        {React.string("Start the mock server to see posts:")}
      </Typography.Body>
      <code
        className={css({
          "display": "block",
          "padding": "0.75rem 1rem",
          "marginTop": "0.75rem",
          "backgroundColor": Color.bgElevated,
          "fontSize": "0.875rem",
          "color": Color.primary,
        })}>
        {React.string("bun run dev:server")}
      </code>
    </div>
  }
}

module Typography = Typography.Typography

@react.component
let make = () => {
  let containerStyles = css({
    "padding": "4rem 1rem",
    "maxWidth": "680px",
    "margin": "0 auto",
  })

  <div className={containerStyles}>
    <Typography.Overline className={css({"marginBottom": "2rem"})}>
      {React.string("Recent Writing")}
    </Typography.Overline>
    <RescriptReactErrorBoundary fallback={_ => <ServerUnavailable />}>
      <React.Suspense
        fallback={<Typography.Body className={css({"color": Color.textSecondary})}> {React.string("Loading...")} </Typography.Body>}>
        <PostsList />
      </React.Suspense>
    </RescriptReactErrorBoundary>
  </div>
}
