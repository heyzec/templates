# nix-templates

A simple repo for me to store my templates

## direnv-shell
1. Use template
    ```
    # For basic template
    nix flake init -t github:heyzec/nix-templates
    # For python
    nix flake init -t github:heyzec/nix-templates#python
    # For postgres
    nix flake init -t github:heyzec/nix-templates#postgres
    ```
    Note: the `--refresh` flag is useful to force redownloads

2. Edit the flake

3. Tell direnv to whitelist it
    ```
    direnv allow
    ```

