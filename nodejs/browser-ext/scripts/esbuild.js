const esbuild = require("esbuild");
const polyfillNode = require("esbuild-plugin-polyfill-node").polyfillNode;

const config = esbuild.context({
  entryPoints: ["src/content_scripts/index.js"],
  bundle: true,
  platform: "browser",
  outfile: "dist/content_scripts/index.js",
  plugins: [
    polyfillNode({
      polyfills: {
        fs: true, // See https://github.com/tree-sitter/tree-sitter/tree/master/lib/binding_web#cant-resolve-fs-in-node_modulesweb-tree-sitter
      },
    }),
  ],
});

main();

async function main() {
  if (process.argv.includes("--watch")) {
    await watch();
  } else {
    await build();
  }
  process.exit(0);
}

async function watch() {
  const context = await config;
  context.watch();
  console.log("Watching files...");
  await new Promise(() => {});
}
async function build() {
  const context = await config;
  await context.rebuild();
  console.log("Builds completed successfully.");
}
