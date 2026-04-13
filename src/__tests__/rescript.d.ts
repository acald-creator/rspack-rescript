declare module "*.bs.js" {
	// biome-ignore lint/suspicious/noExplicitAny: ReScript compiled output has dynamic exports
	const content: Record<string, any>;
	export = content;
}
