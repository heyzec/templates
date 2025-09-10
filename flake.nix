{
  description = "A collection of flake templates";

  outputs = {self}: let
    python = import ./python;
  in {
    templates = {
      basic = {path = ./basic;};

      # Languages
      inherit (python) python python-poetry python-poetry2nix;
      inherit (python) python-telegram-bot;
      nodejs = {path = ./nodejs;};

      postgres = {path = ./postgres;};
      tectonic = {path = ./tectonic;};

      vm = {path = ./vm;};
      digitalocean = {path = ./digitalocean;};
    };

    defaultTemplate = self.templates.basic;
  };
}
