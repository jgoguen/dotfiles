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

async function writeDebugLog(client, message, extra) {
	if (!client?.app?.log) {
		return;
	}

	try {
		await client.app.log({
			body: {
				service: "normalize-workspace-paths",
				level: "debug",
				message,
				extra,
			},
		});
	} catch (error) {
		console.error("[normalize-workspace-paths] failed to write debug log", error);
	}
}

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

export default async function normalizeWorkspacePaths({ client, directory }) {
	const debug = process.env[DEBUG_ENVIRONMENT_VARIABLE] === "1";

	return {
		"tool.execute.before": async ({ tool }, output) => {
			const argument = PATH_ARGUMENTS[tool];
			if (!argument || !output.args || typeof output.args !== "object") {
				if (debug) {
					await writeDebugLog(client, "ignored tool invocation", {
						tool,
						reason: !argument ? "unsupported tool" : "missing args",
					});
				}
				return;
			}

			if (!Object.hasOwn(output.args, argument)) {
				if (debug) {
					await writeDebugLog(client, "ignored tool invocation", {
						tool,
						argument,
						reason: "missing path argument",
					});
				}
				return;
			}

			const original = output.args[argument];
			const result = normalizeWorkspacePath(directory, original);
			output.args[argument] = result;

			if (debug) {
				await writeDebugLog(client, "normalized tool path", {
					tool,
					argument,
					original,
					result,
					changed: original !== result,
				});
			}
		},
	};
}
