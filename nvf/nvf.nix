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
    ui = {
      noice.enable = true;
      illuminate.enable = true;
      nvim-highlight-colors.enable = true;
      borders = {
        enable = true;
        globalStyle = "rounded";
      };
    };
    mini.icons.enable = true;

    visuals = {
      nvim-web-devicons.enable = true;
      rainbow-delimiters.enable = true;
      tiny-devicons-auto-colors.enable = true;
      indent-blankline.enable = true;
      highlight-undo.enable = true;
    };
    dashboard.alpha = {
      enable = true;
      theme = "theta";
    };

    # navigation
    navigation = {
      harpoon = {
        enable = true;
        mappings = {
          file1 = "<leader>1";
          file2 = "<leader>2";
          file3 = "<leader>3";
          file4 = "<leader>4";
          listMarks = "<leader>'";
          markFile = "<leader>.";
        };
        setupOpts.defaults = {
          save_on_toggle = true;
          sync_on_ui_close = true;
        };
      };
    };

    # lsp
    lsp = {
      enable = true;
      formatOnSave = true;
      inlayHints.enable = true;

      lightbulb = {
        enable = true;
        autocmd.enable = true;
      };
      lspconfig.enable = true;
      otter-nvim.enable = true;
    };

    notes.todo-comments.enable = true;

    spellcheck = {
      enable = true;
      programmingWordlist.enable = true;
    };
    comments.comment-nvim = {
      enable = true;

      mappings.toggleCurrentLine = "<leader>/";
      /*
      mappings.toggleOpLeaderLine = "<leader>/";
      */
      /*
      mappings.toggleOpLeaderBlock = "<leader>/";
      */
      /*
      mappings.toggleCurrentBlock = "<leader>/";
      */
      mappings.toggleSelectedLine = "<leader>/";
      /*
      mappings.toggleSelectedBlock = "<leader>/";
      */

      setupOpts.mappings.basic = true;
      setupOpts.mappings.extra = true;
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
      typst.enable = true;
    };

    treesitter = {
      enable = true;
      autotagHtml = true;
      context.enable = true;
      fold = true;
      grammars = pkgs.vimPlugins.nvim-treesitter.allGrammars;
    };

    diagnostics.nvim-lint = {
      enable = true;
      lint_after_save = true;
    };

    # plugins
    extraPlugins = {
      spider = {
        package = pkgs.vimPlugins.nvim-spider;
      };
    };

    utility = {
      multicursors.enable = true;
      surround.enable = true;
      nix-develop.enable = true;
      preview = {glow.enable = true;};
      sleuth.enable = true;
      snacks-nvim = {
        enable = true;

        setupOpts = {
          bigfile.enable = true;
          dashboard = {
            enable = false;
          };
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

    autocomplete.blink-cmp = {
      enable = true;
      friendly-snippets.enable = true;
      # mappings = {
      #   close = "<Esc>"; # abort / close the menu
      #   complete = "<C-Space>"; # trigger completion manually
      #   confirm = "<CR>"; # confirm selected item
      #   next = "<C-n>"; # select next completion item
      #   previous = "<C-p>"; # select previous completion item
      #   scrollDocsDown = "<C-f>"; # scroll docs down
      #   scrollDocsUp = "<C-d>"; # scroll docs up
      # };
      setupOpts = {
        signature.enabled = true;
        cmdline.keymap.preset = "default";
        keymap.preset = "default";
        completion.documentation.auto_show = true;
      };
      sourcePlugins = {
        lsp = {package = "cmp-nvim-lsp";};
        buffer = {package = "cmp-buffer";};
        path = {package = "cmp-path";};
        luasnip = {package = "cmp-luasnip";};
        spell = {package = "blink-cmp-spell";};
        emoji = {package = "blink-emoji-nvim";};
        ripgrep.enable = true;
        spell.enable = true;
      };
    };

    autopairs.nvim-autopairs.enable = true;

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
