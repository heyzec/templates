{pkgs ? import <nixpkgs> {}}:
with pkgs;
  mkShell {
    nativeBuildInputs = with pkgs; [
      # Compilers
      rustc
      cargo

      # Tools
      rust-analyzer
      rustfmt
    ];
  }
