extension-id := "templates.vscode-ext"

install:
    npm run package
    code --install-extension "$(ls -v *.vsix | tail -n1)" --force
    ln -sf $(realpath dist)/extension.js $(echo $HOME/.vscode/extensions/{{extension-id}}-*)/dist/extension.js

reinstall:
    just install
    command -v open >/dev/null 2>&1 && 'vscode://{{extension-id}}/reload' || xdg-open 'vscode://{{extension-id}}/reload'

dev:
    npm run watch
