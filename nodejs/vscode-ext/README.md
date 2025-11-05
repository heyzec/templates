# vscode-ext

<!-- Uncomment after adding repository to package.json (this key is needed for `vsce` to package extensions where README has images)
<p align="center">
   <img src="./assets/icon.png" width="150">
</p>
-->

Sample VSCode extension with project setup for:
- Bundling of node dependencies
- Hot reload during development

## Developer Guide
Setup and install
```sh
npm install
just install
```

Install and trigger reload
```sh
just reinstall
```

Start hot-reload of extension
```sh
just dev
```

### Known issues
**punycode is deprecated**
```
DeprecationWarning: The `punycode` module is deprecated. Please use a userland alternative instead.
```
Wait for https://github.com/markdown-it/markdown-it/issues/1065 to be resolved.
