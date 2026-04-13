@val external fetch: (string, {..}) => promise<{..}> = "fetch"
@val external graphqlEndpoint: string = "process.env.GRAPHQL_ENDPOINT"

let fetchQuery: RescriptRelay.Network.fetchFunctionPromise = async (
  operation,
  variables,
  _cacheConfig,
  _uploadables,
) => {
  let body = JSON.stringifyAny({
    "query": operation.text,
    "variables": variables,
  })->Option.getOr("{}")

  let response = await fetch(
    graphqlEndpoint,
    {
      "method": "POST",
      "headers": {
        "content-type": "application/json",
        "accept": "application/json",
      },
      "body": body,
    },
  )
  await response["json"]()
}

let network = RescriptRelay.Network.makePromiseBased(~fetchFunction=fetchQuery)

let environment = RescriptRelay.Environment.make(
  ~network,
  ~store=RescriptRelay.Store.make(
    ~source=RescriptRelay.RecordSource.make(),
  ),
)
