{
  pkgs,
  enabledLanguages ? ["all"], # "all" or list like ["go" "ts" "python" "markdown"]
  ...
}: let
  # Check if a language should be enabled
  langEnabled = lang:
    builtins.elem "all" enabledLanguages || builtins.elem lang enabledLanguages;

  # Base extra packages (always needed)
  basePackages = with pkgs; [
    ripgrep
    lazygit
    fd
    imagemagick
    alejandra
    nixd
    tree-sitter
  ];

  # Language-specific packages
  langPackages = with pkgs;
    (
      if langEnabled "nix"
      then [nixd nixpkgs-fmt statix]
      else []
    )
    ++ (
      if langEnabled "go"
      then [gopls golangci-lint-langserver golangci-lint gofumpt delve]
      else []
    )
    ++ (
      if langEnabled "ts" || langEnabled "js"
      then [deno vtsls vscode-langservers-extracted emmet-language-server prettierd prettier eslint]
      else []
    )
    ++ (
      if langEnabled "python"
      then [basedpyright ruff python313Packages.debugpy]
      else []
    )
    ++ (
      if langEnabled "markdown"
      then [marksman markdownlint-cli2]
      else []
    )
    ++ (
      if langEnabled "bash"
      then [bash-language-server shfmt shellcheck]
      else []
    )
    ++ (
      if langEnabled "lua"
      then [lua-language-server stylua selene]
      else []
    )
    ++ (
      if langEnabled "clang"
      then [clang-tools cppcheck lldb]
      else []
    )
    ++ (
      if langEnabled "html" || langEnabled "css"
      then [vscode-langservers-extracted emmet-language-server prettierd]
      else []
    )
    ++ (
      if langEnabled "sql"
      then [sqls sqlfluff]
      else []
    )
    ++ (
      if langEnabled "zig"
      then [zls]
      else []
    )
    ++ (
      if langEnabled "typst"
      then [prettypst ghostscript tectonic nodePackages.mermaid-cli]
      else []
    )
    ++ (
      if langEnabled "yaml"
      then [yaml-language-server yamllint]
      else []
    )
    ++ (
      if langEnabled "docker"
      then [docker-language-server hadolint]
      else []
    )
    ++ (
      if langEnabled "json"
      then [jq]
      else []
    );
in {
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
      mappings.toggleSelectedLine = "<leader>/";
      setupOpts.mappings.basic = true;
      setupOpts.mappings.extra = true;
    };

    # Languages - conditionally enabled
    languages = {
      nix = {
        enable = langEnabled "nix";
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
      sql.enable = langEnabled "sql";
      ts.enable = langEnabled "ts" || langEnabled "js";
      python.enable = langEnabled "python";
      zig.enable = langEnabled "zig";
      markdown.enable = langEnabled "markdown";
      html.enable = langEnabled "html";
      go.enable = langEnabled "go";
      lua.enable = langEnabled "lua";
      assembly.enable = langEnabled "assembly";
      bash.enable = langEnabled "bash";
      clang.enable = langEnabled "clang";
      css.enable = langEnabled "css";
      typst.enable = langEnabled "typst";
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
      preview = {glow.enable = langEnabled "markdown";};
      sleuth.enable = true;
      snacks-nvim = {
        enable = true;
        setupOpts = {
          bigfile.enable = true;
          dashboard.enable = false;
          explorer.enable = true;
          indent.enable = true;
          input.enable = true;
          notifier = {
            enable = true;
            timeout = 3000;
          };
          picker.enable = true;
          quickfile.enable = true;
          scope.enable = true;
          scroll.enable = true;
          statuscolumn.enable = true;
          words.enable = true;
          styles.notification = {};
        };
      };
    };

    autocomplete.blink-cmp = {
      enable = true;
      friendly-snippets.enable = true;
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

    # tools - only include packages for enabled languages
    extraPackages = basePackages ++ langPackages;
  };
}
