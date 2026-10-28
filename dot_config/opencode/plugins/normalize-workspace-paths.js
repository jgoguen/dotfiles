import { Plugin } from "@opencode/plugin";
import path from "node:path";

const PATH_ARGUMENTS = {
	edit: "filePath",
	glob: "path",
	grep: "path",
	list: "path",
	read: "filePath",
	write: "filePath",
};

const DEBUG_ENVIRONMENT_VARIABLE = "OPENCODE_NORMALIZE_WORKSPACE_PATHS_DEBUG";

function normalizeWorkspacePath(directory, value) {
	if (typeof value !== "string" || !path.isAbsolute(value)) {
		return value;
	}

	const root = path.resolve(directory);
	const absolute = path.resolve(value);
	const relative = path.relative(root, absolute);

	if (relative === ".." || relative.startsWith(`..${path.sep}`) || path.isAbsolute(relative)) {
		return value;
	}

	return relative || ".";
}

export default Plugin.define({
	id: "normalize-workspace-paths",
	async setup(ctx) {
		const debug = process.env[DEBUG_ENVIRONMENT_VARIABLE] === "1";
		const directory = ctx.location.directory;

		await ctx.tool.hook("execute.before", async (event) => {
			const argument = PATH_ARGUMENTS[event.tool];
			if (!argument || !event.input || typeof event.input !== "object") {
				if (debug) {
					console.log("[normalize-workspace-paths] ignored", { tool: event.tool, reason: !argument ? "unsupported" : "missing args" });
				}
				return;
			}

			if (!Object.hasOwn(event.input, argument)) {
				if (debug) {
					console.log("[normalize-workspace-paths] ignored", { tool: event.tool, argument, reason: "missing path argument" });
				}
				return;
			}

			const original = event.input[argument];
			const result = normalizeWorkspacePath(directory, original);
			event.input[argument] = result;

			if (debug) {
				console.log("[normalize-workspace-paths] normalized", {
					tool: event.tool,
					argument,
					original,
					result,
					changed: original !== result,
				});
			}
		});
	},
});
