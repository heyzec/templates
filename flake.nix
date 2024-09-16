{
  description = "A collection of flake templates";

  outputs = { self }: let
    python = import ./python;
  in {
    templates = {
      basic = {
        path = ./basic;
      };
      inherit (python) python python-poetry python-poetry2nix;
      inherit (python) python-telegram-bot;
      postgres = { path = ./postgres; };
      node = { path = ./node; };
      tectonic = { path = ./tectonic; };
      vm = { path = ./vm; };
    };

    defaultTemplate = self.templates.basic;
  };
}
