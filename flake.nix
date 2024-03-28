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
      vm = {
        path = ./vm;
        description = "a very basic flake for building NixOS VMs";
      };
    };

    defaultTemplate = self.templates.basic;
  };
}

