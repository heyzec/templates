{
  description = "A collection of flake templates";

  outputs = { self }: {
    templates = {
      basic = {
        path = ./basic;
        description = "a very basic flake for direnv";
      };
      python = {
        path = ./python;
        description = "a very basic flake for direnv, with Python";
      };
      postgres = {
        path = ./postgres;
        description = "a very basic flake for direnv, with Postgres DB";
      };
    };

    defaultTemplate = self.templates.basic;
  };
}

