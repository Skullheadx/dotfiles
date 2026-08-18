{
  config,
  inputs,
  ips,
  pkgs,
  ...
}: {
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedOptimisation = true;
    experimentalZstdSettings = true;
    recommendedBrotliSettings = true;
    recommendedGzipSettings = true;
    validateConfigFile = true;
    appendHttpConfig = ''
      log_format main '$remote_addr - $remote_user [$time_local] "$request" '
                       '$status $body_bytes_sent "$http_referer" '
                       '"$http_user_agent"';

      access_log /var/log/nginx/access.log main;

      set_real_ip_from ${ips.ip_wg_vps};
      real_ip_header X-Forwarded-For;

      map $request_uri $limit_key {
        default "";
        ~^/nixpkgs/atom  $binary_remote_addr;
      }

      limit_req_zone $limit_key zone=expensive:10m rate=1r/m;

      map $http_user_agent $bot_class {
          default                        "";
          ~*GPTBot                       "gptbot";
          ~*Amazonbot                    "amazonbot";
          ~*meta-externalagent           "metabot";
      }

      limit_req_zone $bot_class zone=bots:10m rate=1r/m;


    '';
    virtualHosts = {
      "git.skullheadx.com" = {
        listen = [
          {
            addr = "${ips.ip_wg_homelab}";
            port = 8080;
          }
          {
            addr = "${ips.ip_local_homelab}";
            port = 8080;
          }
        ];

        extraConfig = ''
          limit_req zone=expensive burst=1 nodelay;
          limit_req zone=bots burst=3 nodelay;
        '';
        locations = {
          "/cgit/" = {
            alias = "/srv/git/cgit/";
          };
          "= /robots.txt" = {
            alias = "/srv/git/cgit/robots.txt";
          };
        };
      };
    };
  };
  systemd.services.nginx.serviceConfig = {
    SupplementaryGroups = ["git"];
    ReadOnlyPaths = [
      "/srv/git"
      "/srv"
    ];
    InaccessiblePaths = [
      "/srv/git/.ssh"
      # "/srv/git/migrate_from_gh.sh"
      # "/srv/git/make_new_repo.sh"
    ];
  };

  services.gitDaemon = {
    enable = true;
    basePath = "/srv/git";
    listenAddress = "0.0.0.0";
    exportAll = false;
  };

  # Must redirect git to go over localhost to avoid fetching errors trying to get the router to reroute the source and dest ip addrs being the same (homelab)
  programs.git.config.url."git://127.0.0.1/" = {
    insteadOf = [
      "git://git.skullheadx.com/"
    ];
  };

  # Git web frontend
  services.cgit."cgit" = {
    enable = true;
    scanPath = "/srv/git";
    settings = {
      # readme = "";
      remove-suffix = true;
      root-title = "Skullheadx's Git Forge";
      root-desc = "Source code for various projects";
      repository-sort = "age";
      enable-follow-links = true;
      source-filter = "${pkgs.cgit}/lib/cgit/filters/syntax-highlighting.py";
      strict-export = "git-daemon-export-ok";
      cache-size = 1000;
      cache-root = "/srv/git/.cache";
      clone-url = "git://git.skullheadx.com/$CGIT_REPO_URL";
      enable-http-clone = true;
      enable-index-links = true;
      enable-blame = true;
      enable-commit-graph = true;
      enable-log-filecount = true;
      enable-log-linecount = true;
      enable-subject-links = true;
      # enable-owner-index = false;
      enable-git-config = true;
      local-time = true;
      branch-sort = "age";
      max-stats = "quarter";
      snapshots = "tar.gz tar.bz2 zip";
      logo-link = "https://git.skullheadx.com";
      favicon = "/cgit/favicon.ico";
      logo = "/cgit/logo.webp";
      css = "/cgit/cgit.css";
    };
    extraConfig = ''
      mimetype.gif=image/gif
      mimetype.html=text/html
      mimetype.jpg=image/jpeg
      mimetype.jpeg=image/jpeg
      mimetype.pdf=application/pdf
      mimetype.png=image/png
      mimetype.webp=image/webp
      mimetype.svg=image/svg+xml

      readme=:README.md
      readme=:readme.md
      readme=:README.mkd
      readme=:readme.mkd
      readme=:README.rst
      readme=:readme.rst
      readme=:README.html
      readme=:readme.html
      readme=:README.htm
      readme=:readme.htm
      readme=:README.txt
      readme=:readme.txt
      readme=:README
      readme=:readme
      readme=:INSTALL.md
      readme=:install.md
      readme=:INSTALL.mkd
      readme=:install.mkd
      readme=:INSTALL.rst
      readme=:install.rst
      readme=:INSTALL.html
      readme=:install.html
      readme=:INSTALL.htm
      readme=:install.htm
      readme=:INSTALL.txt
      readme=:install.txt
      readme=:INSTALL
      readme=:install


    '';

    gitHttpBackend = {
      enable = true;
      checkExportOkFiles = true;
    };
    nginx = {
      location = "";
      virtualHost = "git.skullheadx.com";
    };
  };

  services.fcgiwrap.instances."cgit-cgit".process.prefork = 8;
}
