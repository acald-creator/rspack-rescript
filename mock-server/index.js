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

let posts = [
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

const server = createServer(yoga);

server.listen(4000, () => {
	console.log("GraphQL server running at http://localhost:4000/graphql");
});
