import * as vscode from "vscode";
import * as path from "path";
import * as fs from "fs";

interface Extension {
  activate(context: vscode.ExtensionContext): vscode.Disposable[];
}

let ext: Extension = require("./extension");

const managedDisposables: Set<vscode.Disposable> = new Set();

export function activate(context: vscode.ExtensionContext) {
  vscode.window.registerUriHandler({
    handleUri(uri: vscode.Uri) {
      if (uri.path === "/reload") {
        vscode.commands.executeCommand("workbench.action.reloadWindow");
      }
    },
  });

  const disposables = ext.activate(context);
  context.subscriptions.push(...disposables);
  disposables.forEach((d) => managedDisposables.add(d));

  const extPath = path.join(context.extensionPath, "dist", "extension.js");

  console.log(`Watching for changes in ${extPath}`);
  fs.watchFile(extPath, () => {
    delete require.cache[require.resolve(extPath)];
    ext = require(extPath);

    managedDisposables.forEach((disposable) => disposable.dispose());

    context.subscriptions.filter((d) => !managedDisposables.has(d));
    const disposables = ext.activate(context);
    managedDisposables.forEach((d) => d.dispose());
    managedDisposables.clear();
    disposables.forEach((d) => managedDisposables.add(d));

    vscode.window.showInformationMessage("Reloaded extension!");
  });
}

export function deactivate() {}
