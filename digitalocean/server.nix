{
  networking.firewall = {
    allowedTCPPorts = [80 443];
  };

  services.caddy = {
    enable = true;
    virtualHosts = {
      "https://frontend.cloud.heyzec.dedyn.io" = {
        extraConfig = ''
          root * /app/frontend/build
          try_files {path} /index.html
          file_server
        '';
      };
      "https://backend.cloud.heyzec.dedyn.io" = {
        extraConfig = ''
          reverse_proxy :4000
        '';
      };
    };
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [
      "cadet_dev"
    ];
    ensureUsers = [
      {
        name = "root";
        ensureClauses.superuser = true;
      }
    ];
  };
}
