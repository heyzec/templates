{
  description = "A collection of flake templates";

  outputs = { self }: {
    templates = {
      basic = {
        path = ./basic;
      };
      python = {
        path = ./python;
      };
      postgres = {
        path = ./postgres;
      };
      node = {
        path = ./node;
      };
      vm = {
        path = ./vm;
      };
    };

    defaultTemplate = self.templates.basic;
  };
}

