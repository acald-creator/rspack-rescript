// Standalone OAuth 2.0 PKCE implementation
// When @cosmonexus/oauth-client is available, swap this for the library bindings below.

type config = {
  clientId: string,
  redirectUri: string,
  authorizeUrl: string,
  tokenUrl: string,
  scopes: array<string>,
}

type tokenSet = {
  accessToken: string,
  tokenType: string,
  expiresIn: int,
}

@val external encodeURIComponent: string => string = "encodeURIComponent"

let generateRandomString: int => string = %raw(`
  function(length) {
    var array = new Uint8Array(length);
    crypto.getRandomValues(array);
    var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~";
    var result = "";
    for (var i = 0; i < length; i++) {
      result += chars[array[i] % chars.length];
    }
    return result;
  }
`)

let generateCodeChallenge: string => promise<string> = %raw(`
  async function(verifier) {
    var encoder = new TextEncoder();
    var data = encoder.encode(verifier);
    var hash = await crypto.subtle.digest("SHA-256", data);
    var bytes = new Uint8Array(hash);
    var str = "";
    for (var i = 0; i < bytes.length; i++) {
      str += String.fromCharCode(bytes[i]);
    }
    return btoa(str).replace(/\+/g, "-").replace(/\//g, "_").replace(/=+$/, "");
  }
`)

let startAuth = async (config: config) => {
  let codeVerifier = generateRandomString(64)
  let codeChallenge = await generateCodeChallenge(codeVerifier)
  let state = generateRandomString(32)

  ignore(%raw(`sessionStorage.setItem("pkce_code_verifier", codeVerifier)`))
  ignore(%raw(`sessionStorage.setItem("pkce_state", state)`))

  let params = [
    ("client_id", config.clientId),
    ("redirect_uri", config.redirectUri),
    ("response_type", "code"),
    ("code_challenge", codeChallenge),
    ("code_challenge_method", "S256"),
    ("state", state),
    ("scope", config.scopes->Array.join(" ")),
  ]

  let queryString =
    params->Array.map(((k, v)) => `${k}=${encodeURIComponent(v)}`)->Array.join("&")

  `${config.authorizeUrl}?${queryString}`
}

@val external fetchRaw: (string, {..}) => promise<{..}> = "fetch"

let clearPkceStorage: unit => unit = %raw(`
  function() {
    sessionStorage.removeItem("pkce_code_verifier");
    sessionStorage.removeItem("pkce_state");
  }
`)

let exchangeCode = async (config: config, code: string) => {
  let codeVerifier: string = %raw(`sessionStorage.getItem("pkce_code_verifier") || ""`)

  if String.length(codeVerifier) === 0 {
    clearPkceStorage()
    JsError.throwWithMessage("PKCE code verifier not found in session storage")
  }

  let body =
    [
      ("grant_type", "authorization_code"),
      ("client_id", config.clientId),
      ("code", code),
      ("redirect_uri", config.redirectUri),
      ("code_verifier", codeVerifier),
    ]
    ->Array.map(((k, v)) => `${k}=${encodeURIComponent(v)}`)
    ->Array.join("&")

  let response = await fetchRaw(
    config.tokenUrl,
    {
      "method": "POST",
      "headers": {
        "content-type": "application/x-www-form-urlencoded",
      },
      "body": body,
    },
  )
  let json = await response["json"]()

  clearPkceStorage()

  let ok: bool = response["ok"]
  if !ok {
    let status: int = response["status"]
    let errorMsg: string = json["error"]
    JsError.throwWithMessage(`Token exchange failed (${Int.toString(status)}): ${errorMsg}`)
  }

  let accessToken: Nullable.t<string> = json["access_token"]
  let tokenType: Nullable.t<string> = json["token_type"]
  let expiresIn: Nullable.t<int> = json["expires_in"]

  switch (accessToken->Nullable.toOption, tokenType->Nullable.toOption, expiresIn->Nullable.toOption) {
  | (Some(at), Some(tt), Some(ei)) => {
      accessToken: at,
      tokenType: tt,
      expiresIn: ei,
    }
  | _ => JsError.throwWithMessage("Token response missing required fields (access_token, token_type, expires_in)")
  }
}

// --- @cosmonexus/oauth-client bindings (commented out) ---
// Uncomment and use these when the packages are published to npm.
// Also update AuthContext.res to use OAuthReact.AuthProvider and useAuth.
//
// type oauthClientConfig = {
//   issuerBaseUrl: string,
//   clientId: string,
//   redirectUri?: string,
//   scopes?: array<string>,
//   storagePrefix?: string,
// }
//
// type oauthClient
//
// @new @module("@cosmonexus/oauth-client")
// external makeClient: oauthClientConfig => oauthClient = "OAuthClient"
//
// @send
// external authorize: (oauthClient, authorizeOptions) => promise<authorizeResult> = "authorize"
//
// @send
// external login: (oauthClient, authorizeOptions) => promise<unit> = "login"
//
// @send
// external handleCallback: (oauthClient, string) => callbackResult = "handleCallback"
//
// @send
// external logout: oauthClient => unit = "logout"
//
// @send
// external clearState: oauthClient => unit = "clearState"
