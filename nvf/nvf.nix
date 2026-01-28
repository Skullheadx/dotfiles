{pkgs, ...}: {
  config.vim = {
    # core
    syntaxHighlighting = true;
    binds.whichKey.enable = true;

    # ui
    theme = {
      enable = true;
      name = "tokyonight";
      style = "storm";
      transparent = true;
    };

    statusline.lualine.enable = true;
    ui.noice.enable = true;
    mini.icons.enable = true;

    visuals = {
      nvim-web-devicons.enable = true;
      rainbow-delimiters.enable = true;
      tiny-devicons-auto-colors.enable = true;
      indent-blankline.enable = true;
    };

    # lsp
    lsp = {
      enable = true;
      formatOnSave = true;
      inlayHints.enable = true;
      lspSignature.enable = true;

      lightbulb = {
        enable = true;
        autocmd.enable = true;
      };
      lspconfig.enable = true;
    };

    languages = {
      nix = {
        enable = true;
        format = {
          enable = true;
          type = ["alejandra"];
        };
        lsp = {
          enable = true;
          servers = ["nixd"];
        };
        treesitter.enable = true;
      };
      sql.enable = true;
      ts.enable = true;
      python.enable = true;
      zig.enable = true;
      markdown.enable = true;
      html.enable = true;
      go.enable = true;
      lua.enable = true;
      assembly.enable = true;
      bash.enable = true;
      clang.enable = true;
      css.enable = true;
    };

    treesitter = {
      enable = true;
      autotagHtml = true;
      context.enable = true;
      fold = true;
      grammars = pkgs.vimPlugins.nvim-treesitter.allGrammars;
    };

    # plugins
    utility = {
      nix-develop.enable = true;
      sleuth.enable = true;
      snacks-nvim = {
        enable = true;

        setupOpts = {
          bigfile.enable = true;
          dashboard.enable = true;
          explorer.enable = true;
          indent.enable = true;
          input.enable = true;

          notifier = {
            enable = true;
            timeout = 3000;
          };

          picker = {
            enable = true;
          };
          quickfile.enable = true;
          scope.enable = true;
          scroll.enable = true;
          statuscolumn.enable = true;
          words.enable = true;

          styles.notification = {
            # wo.wrap = true;
          };
        };
      };
    };

    # keymaps
    keymaps = import ./keymaps.nix {};

    # tools
    extraPackages = with pkgs; [
      ripgrep
      lazygit
      fd
      imagemagick
      alejandra
      nixd
      ghostscript
      tectonic
      nodePackages.mermaid-cli

      # language server
      bash-language-server
      clang-tools
      docker-language-server
      gopls
      golangci-lint-langserver
      vscode-langservers-extracted
      emmet-language-server
      lua-language-server
      marksman
      nixd
      basedpyright
      ruff
      sqls
      deno
      vtsls
      yaml-language-server
      zls

      # formatter
      shfmt
      gofumpt
      prettierd
      prettier
      jq
      stylua
      nixpkgs-fmt
      sqlfluff

      # linter
      shellcheck
      cppcheck
      hadolint
      fish
      golangci-lint
      selene
      markdownlint-cli2
      statix
      eslint
      yamllint

      # debugger
      lldb
      delve
      python313Packages.debugpy

      # tree sitter
      tree-sitter
    ];
  };
}
