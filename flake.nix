{
  description = "A collection of flake templates";

  outputs = { self }: {
    templates = {
      direnv-shell = {
        path = ./direnv-shell;
        description = "a very basic flake for direnv";
      };
      python-shell = {
        path = ./python;
        description = "a very basic flake for direnv, with Python";
      };
      postgres-shell = {
        path = ./postgres;
        description = "a very basic flake for direnv, with Postgres DB";
      };
    };

    defaultTemplate = self.templates.direnv-shell;
  };
}

