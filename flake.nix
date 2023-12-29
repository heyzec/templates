{
  description = "A collection of flake templates";

  outputs = { self }: {
    templates = {
      direnv-shell = {
        path = ./direnv-shell;
        description = "A very basic flake for direnv";
      };
    };

    defaultTemplate = self.templates.direnv-shell;
  };
}

