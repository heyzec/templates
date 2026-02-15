{
  description = "A collection of flake templates";

  outputs = {self}: let
    python = import ./python;
    nodejs = import ./nodejs;
  in {
    templates = {
      basic = {path = ./basic;};

      # Python
      inherit (python) python python-poetry python-poetry2nix;
      inherit (python) python-telegram-bot;
      # JavaScript / Node.js
      inherit (nodejs) nodejs browser-ext vscode-ext;
      # Go
      go = {path = ./go;};

      postgres = {path = ./postgres;};
      tectonic = {path = ./tectonic;};

      vm = {path = ./vm;};
      digitalocean = {path = ./digitalocean;};
    };

    defaultTemplate = self.templates.basic;
  };
}
