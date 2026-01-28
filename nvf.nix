{pkgs, ...}: {
  config.vim = {
    # lazy = {
    #   enable = true;
    #   enableLznAutoRequire = true;
    # };

    startPlugins = [
    ];

    syntaxHighlighting = true;
    statusline.lualine.enable = true;

    ui.noice.enable = true;

    theme = {
      enable = true;
      name = "tokyonight";
      style = "storm";
      transparent = true;
    };

    binds.whichKey.enable = true;

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

    mini.icons.enable = true;
    visuals = {
      nvim-web-devicons.enable = true;
      rainbow-delimiters.enable = true;
      tiny-devicons-auto-colors.enable = true;
      indent-blankline.enable = true;
    };

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
    keymaps = [
      # Top Pickers & Explorer
      {
        key = "<leader><space>";
        mode = "n";
        silent = true;
        desc = "Smart Find Files";
        action = "<cmd>lua Snacks.picker.smart()<CR>";
      }
      {
        key = "<leader>f\/";
        mode = "n";
        silent = true;
        desc = "Grep";
        action = "<cmd>lua Snacks.picker.grep()<CR>";
      }
      {
        key = "<leader>:";
        mode = "n";
        silent = true;
        desc = "Command History";
        action = "<cmd>lua Snacks.picker.command_history()<CR>";
      }
      {
        key = "<leader>e";
        mode = "n";
        silent = true;
        desc = "File Explorer";
        action = "<cmd>lua Snacks.explorer()<CR>";
      }

      # Find
      {
        key = "<leader>fb";
        mode = "n";
        silent = true;
        desc = "Buffers";
        action = "<cmd>lua Snacks.picker.buffers()<CR>";
      }
      {
        key = "<leader>fc";
        mode = "n";
        silent = true;
        desc = "Find Config File";
        action = "<cmd>lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })<CR>";
      }
      {
        key = "<leader>ff";
        mode = "n";
        silent = true;
        desc = "Find Files";
        action = "<cmd>lua Snacks.picker.files()<CR>";
      }
      {
        key = "<leader>fg";
        mode = "n";
        silent = true;
        desc = "Find Git Files";
        action = "<cmd>lua Snacks.picker.git_files()<CR>";
      }
      {
        key = "<leader>fp";
        mode = "n";
        silent = true;
        desc = "Projects";
        action = "<cmd>lua Snacks.picker.projects()<CR>";
      }
      {
        key = "<leader>fr";
        mode = "n";
        silent = true;
        desc = "Recent";
        action = "<cmd>lua Snacks.picker.recent()<CR>";
      }

      # Git
      {
        key = "<leader>gb";
        mode = "n";
        silent = true;
        desc = "Git Branches";
        action = "<cmd>lua Snacks.picker.git_branches()<CR>";
      }
      {
        key = "<leader>gl";
        mode = "n";
        silent = true;
        desc = "Git Log";
        action = "<cmd>lua Snacks.picker.git_log()<CR>";
      }
      {
        key = "<leader>gL";
        mode = "n";
        silent = true;
        desc = "Git Log Line";
        action = "<cmd>lua Snacks.picker.git_log_line()<CR>";
      }
      {
        key = "<leader>gs";
        mode = "n";
        silent = true;
        desc = "Git Status";
        action = "<cmd>lua Snacks.picker.git_status()<CR>";
      }
      {
        key = "<leader>gS";
        mode = "n";
        silent = true;
        desc = "Git Stash";
        action = "<cmd>lua Snacks.picker.git_stash()<CR>";
      }
      {
        key = "<leader>gd";
        mode = "n";
        silent = true;
        desc = "Git Diff (Hunks)";
        action = "<cmd>lua Snacks.picker.git_diff()<CR>";
      }
      {
        key = "<leader>gf";
        mode = "n";
        silent = true;
        desc = "Git Log File";
        action = "<cmd>lua Snacks.picker.git_log_file()<CR>";
      }

      # GitHub
      {
        key = "<leader>gi";
        mode = "n";
        silent = true;
        desc = "GitHub Issues (open)";
        action = "<cmd>lua Snacks.picker.gh_issue()<CR>";
      }
      {
        key = "<leader>gI";
        mode = "n";
        silent = true;
        desc = "GitHub Issues (all)";
        action = "<cmd>lua Snacks.picker.gh_issue({ state = 'all' })<CR>";
      }
      {
        key = "<leader>gp";
        mode = "n";
        silent = true;
        desc = "GitHub Pull Requests (open)";
        action = "<cmd>lua Snacks.picker.gh_pr()<CR>";
      }
      {
        key = "<leader>gP";
        mode = "n";
        silent = true;
        desc = "GitHub Pull Requests (all)";
        action = "<cmd>lua Snacks.picker.gh_pr({ state = 'all' })<CR>";
      }

      # Grep
      {
        key = "<leader>sb";
        mode = "n";
        silent = true;
        desc = "Buffer Lines";
        action = "<cmd>lua Snacks.picker.lines()<CR>";
      }
      {
        key = "<leader>sB";
        mode = "n";
        silent = true;
        desc = "Grep Open Buffers";
        action = "<cmd>lua Snacks.picker.grep_buffers()<CR>";
      }
      {
        key = "<leader>fg";
        mode = "n";
        silent = true;
        desc = "Grep";
        action = "<cmd>lua Snacks.picker.grep()<CR>";
      }
      {
        key = "<leader>fw";
        mode = ["n" "x"];
        silent = true;
        desc = "Visual selection or word";
        action = "<cmd>lua Snacks.picker.grep_word()<CR>";
      }

      # Search
      {
        key = "<leader>s\"";
        mode = "n";
        silent = true;
        desc = "Registers";
        action = "<cmd>lua Snacks.picker.registers()<CR>";
      }
      {
        key = "<leader>sa";
        mode = "n";
        silent = true;
        desc = "Autocmds";
        action = "<cmd>lua Snacks.picker.autocmds()<CR>";
      }
      {
        key = "<leader>sc";
        mode = "n";
        silent = true;
        desc = "Command History";
        action = "<cmd>lua Snacks.picker.command_history()<CR>";
      }
      {
        key = "<leader>sC";
        mode = "n";
        silent = true;
        desc = "Commands";
        action = "<cmd>lua Snacks.picker.commands()<CR>";
      }
      {
        key = "<leader>sd";
        mode = "n";
        silent = true;
        desc = "Diagnostics";
        action = "<cmd>lua Snacks.picker.diagnostics()<CR>";
      }
      {
        key = "<leader>sD";
        mode = "n";
        silent = true;
        desc = "Buffer Diagnostics";
        action = "<cmd>lua Snacks.picker.diagnostics_buffer()<CR>";
      }
      {
        key = "<leader>sh";
        mode = "n";
        silent = true;
        desc = "Help Pages";
        action = "<cmd>lua Snacks.picker.help()<CR>";
      }
      {
        key = "<leader>sH";
        mode = "n";
        silent = true;
        desc = "Highlights";
        action = "<cmd>lua Snacks.picker.highlights()<CR>";
      }
      {
        key = "<leader>si";
        mode = "n";
        silent = true;
        desc = "Icons";
        action = "<cmd>lua Snacks.picker.icons()<CR>";
      }
      {
        key = "<leader>sj";
        mode = "n";
        silent = true;
        desc = "Jumps";
        action = "<cmd>lua Snacks.picker.jumps()<CR>";
      }
      {
        key = "<leader>sk";
        mode = "n";
        silent = true;
        desc = "Keymaps";
        action = "<cmd>lua Snacks.picker.keymaps()<CR>";
      }
      {
        key = "<leader>sl";
        mode = "n";
        silent = true;
        desc = "Location List";
        action = "<cmd>lua Snacks.picker.loclist()<CR>";
      }
      {
        key = "<leader>sm";
        mode = "n";
        silent = true;
        desc = "Marks";
        action = "<cmd>lua Snacks.picker.marks()<CR>";
      }
      {
        key = "<leader>sM";
        mode = "n";
        silent = true;
        desc = "Man Pages";
        action = "<cmd>lua Snacks.picker.man()<CR>";
      }
      {
        key = "<leader>sq";
        mode = "n";
        silent = true;
        desc = "Quickfix List";
        action = "<cmd>lua Snacks.picker.qflist()<CR>";
      }
      {
        key = "<leader>f<CR>";
        mode = "n";
        silent = true;
        desc = "Resume";
        action = "<cmd>lua Snacks.picker.resume()<CR>";
      }
      {
        key = "<leader>su";
        mode = "n";
        silent = true;
        desc = "Undo History";
        action = "<cmd>lua Snacks.picker.undo()<CR>";
      }

      # LSP
      {
        key = "gd";
        mode = "n";
        silent = true;
        desc = "Goto Definition";
        action = "<cmd>lua Snacks.picker.lsp_definitions()<CR>";
      }
      {
        key = "gD";
        mode = "n";
        silent = true;
        desc = "Goto Declaration";
        action = "<cmd>lua Snacks.picker.lsp_declarations()<CR>";
      }
      {
        key = "gr";
        mode = "n";
        silent = true;
        nowait = true;
        desc = "References";
        action = "<cmd>lua Snacks.picker.lsp_references()<CR>";
      }
      {
        key = "gI";
        mode = "n";
        silent = true;
        desc = "Goto Implementation";
        action = "<cmd>lua Snacks.picker.lsp_implementations()<CR>";
      }
      {
        key = "gy";
        mode = "n";
        silent = true;
        desc = "Goto Type Definition";
        action = "<cmd>lua Snacks.picker.lsp_type_definitions()<CR>";
      }
      {
        key = "<leader>ls";
        mode = "n";
        silent = true;
        desc = "LSP Symbols";
        action = "<cmd>lua Snacks.picker.lsp_symbols()<CR>";
      }
      {
        key = "<leader>lS";
        mode = "n";
        silent = true;
        desc = "LSP Workspace Symbols";
        action = "<cmd>lua Snacks.picker.lsp_workspace_symbols()<CR>";
      }

      # Other
      {
        key = "<leader>z";
        mode = "n";
        silent = true;
        desc = "Toggle Zen Mode";
        action = "<cmd>lua Snacks.zen()<CR>";
      }
      {
        key = "<leader>ss";
        mode = "n";
        silent = true;
        desc = "Toggle Scratch Buffer";
        action = "<cmd>lua Snacks.scratch()<CR>";
      }
      {
        key = "<leader>sf";
        mode = "n";
        silent = true;
        desc = "Select Scratch Buffer";
        action = "<cmd>lua Snacks.scratch.select()<CR>";
      }
      {
        key = "<leader>bd";
        mode = "n";
        silent = true;
        desc = "Delete Buffer";
        action = "<cmd>lua Snacks.bufdelete()<CR>";
      }
      {
        key = "<leader>br";
        mode = "n";
        silent = true;
        desc = "Rename File";
        action = "<cmd>lua Snacks.rename.rename_file()<CR>";
      }
      {
        key = "<leader>gB";
        mode = ["n" "v"];
        silent = true;
        desc = "Git Browse";
        action = "<cmd>lua Snacks.gitbrowse()<CR>";
      }
      {
        key = "<leader>gg";
        mode = "n";
        silent = true;
        desc = "Lazygit";
        action = "<cmd>lua Snacks.lazygit()<CR>";
      }
      {
        key = ",t";
        mode = "n";
        silent = true;
        desc = "Toggle Terminal";
        action = "<cmd>lua Snacks.terminal()<CR>";
      }
      {
        key = ",t";
        mode = "t";
        silent = true;
        desc = "which_key_ignore";
        action = "<cmd>lua Snacks.terminal()<CR>";
      }
    ];

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
