import { createSchema, createYoga } from "graphql-yoga";
import { createServer } from "node:http";
import { readFileSync } from "node:fs";
import { join, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const typeDefs = readFileSync(join(__dirname, "schema.graphql"), "utf-8");

const users = [
	{
		id: "user-1",
		name: "Alice Chen",
		email: "alice@example.com",
		avatarUrl: null,
	},
	{
		id: "user-2",
		name: "Bob Martinez",
		email: "bob@example.com",
		avatarUrl: null,
	},
];

const posts = [
	{
		id: "post-1",
		title: "Getting Started with ReScript",
		body: "ReScript is a robustly typed language that compiles to efficient and human-readable JavaScript. It comes with a lightning fast compiler toolchain that scales to any codebase size.",
		createdAt: "2026-04-10T10:00:00Z",
		authorId: "user-1",
	},
	{
		id: "post-2",
		title: "Building with Rspack",
		body: "Rspack is a high performance JavaScript bundler written in Rust. It offers strong compatibility with the webpack ecosystem while providing significantly better build performance.",
		createdAt: "2026-04-11T14:30:00Z",
		authorId: "user-2",
	},
	{
		id: "post-3",
		title: "Emotion CSS-in-JS Patterns",
		body: "Emotion is a performant and flexible CSS-in-JS library. It allows you to style applications with string or object styles and has a predictable composition model.",
		createdAt: "2026-04-12T09:15:00Z",
		authorId: "user-1",
	},
];

let nextPostId = 4;

const resolvers = {
	Query: {
		posts: () => posts,
		post: (_, { id }) => posts.find((p) => p.id === id) || null,
		me: () => users[0],
	},
	Mutation: {
		createPost: (_, { title, body }) => {
			const post = {
				id: `post-${nextPostId++}`,
				title,
				body,
				createdAt: new Date().toISOString(),
				authorId: "user-1",
			};
			posts.unshift(post);
			return post;
		},
	},
	Post: {
		author: (post) => users.find((u) => u.id === post.authorId),
	},
	Node: {
		__resolveType: (obj) => {
			if (obj.email) return "User";
			if (obj.title) return "Post";
			return null;
		},
	},
};

const yoga = createYoga({
	schema: createSchema({ typeDefs, resolvers }),
	cors: {
		origin: "http://localhost:8080",
		credentials: true,
	},
});

// Store pending auth codes for the mock OAuth flow
const pendingCodes = new Map();

const server = createServer((req, res) => {
	const url = new URL(req.url, `http://${req.headers.host}`);

	// Mock OAuth authorize endpoint
	if (url.pathname === "/oauth/authorize") {
		const redirectUri = url.searchParams.get("redirect_uri");
		const state = url.searchParams.get("state");
		const code = `mock-code-${Date.now()}`;

		// Store the code verifier expectation
		pendingCodes.set(code, {
			codeChallenge: url.searchParams.get("code_challenge"),
			clientId: url.searchParams.get("client_id"),
		});

		// Redirect back with code and state (simulates user approving)
		const callbackUrl = `${redirectUri}?code=${code}&state=${state}`;
		res.writeHead(302, { Location: callbackUrl });
		res.end();
		return;
	}

	// Mock OAuth token endpoint
	if (url.pathname === "/oauth/token" && req.method === "POST") {
		let body = "";
		req.on("data", (chunk) => {
			body += chunk;
		});
		req.on("end", () => {
			const params = new URLSearchParams(body);
			const code = params.get("code");

			if (code && pendingCodes.has(code)) {
				pendingCodes.delete(code);
				res.writeHead(200, {
					"Content-Type": "application/json",
					"Access-Control-Allow-Origin": "http://localhost:8080",
				});
				res.end(
					JSON.stringify({
						access_token: `mock-token-${Date.now()}`,
						token_type: "Bearer",
						expires_in: 3600,
					}),
				);
			} else {
				res.writeHead(400, {
					"Content-Type": "application/json",
					"Access-Control-Allow-Origin": "http://localhost:8080",
				});
				res.end(JSON.stringify({ error: "invalid_grant" }));
			}
		});
		return;
	}

	// CORS preflight for token endpoint
	if (url.pathname === "/oauth/token" && req.method === "OPTIONS") {
		res.writeHead(204, {
			"Access-Control-Allow-Origin": "http://localhost:8080",
			"Access-Control-Allow-Methods": "POST, OPTIONS",
			"Access-Control-Allow-Headers": "Content-Type",
		});
		res.end();
		return;
	}

	// Pass everything else to GraphQL yoga
	yoga(req, res);
});

server.listen(4000, () => {
	console.log("GraphQL server running at http://localhost:4000/graphql");
	console.log(
		"OAuth endpoints at http://localhost:4000/oauth/authorize and /oauth/token",
	);
});
