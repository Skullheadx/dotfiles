{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  config.vim = {
    viAlias = true;
    vimAlias = true;
    debugMode = {
      enable = false;
      level = 16;
      logFile = "/tmp/nvim.log";
    };

    spellcheck = {
      enable = true;
      programmingWordlist.enable = true;
    };

    lsp = {
      # This must be enabled for the language modules to hook into
      # the LSP API.
      enable = true;

      formatOnSave = true;
      lspkind.enable = false;
      lightbulb.enable = true;
      lspsaga.enable = false;
      trouble.enable = true;
      lspSignature.enable = !true; # conflicts with blink in maximal
      otter-nvim.enable = true;
      nvim-docs-view.enable = true;
    };

    debugger = {
      nvim-dap = {
        enable = true;
        ui.enable = true;
      };
    };

    # This section does not include a comprehensive list of available language modules.
    # To list all available language module options, please visit the nvf manual.
    languages = {
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;

      # Languages that will be supported in default and maximal configurations.
      nix.enable = true;
      markdown = {
        enable = true;
        extensions.render-markdown-nvim = {
          enable = true;
          setupOpts = {
            enabled = true;
            render_modes = ["n" "c" "t"];
            max_file_size = 10.0;
            debounce = 100;
            preset = "none";
            log_level = "error";
            log_runtime = false;
            file_types = ["markdown"];
            #ignore = ''
            #  function()
            #    return false
            #  end
            #'';
            #nested = true;
            change_events = {};
            #restart_highlighter = false;
            injections = {
              gitcommit = {
                enabled = true;
                query = ''
                  ((message) @injection.content
                      (#set! injection.combined)
                      (#set! injection.include-children)
                      (#set! injection.language "markdown"))
                '';
              };
            };
            patterns = {
              markdown = {
                disable = true;
                directives = [
                  {
                    id = 17;
                    name = "conceal_lines";
                  }
                  {
                    id = 18;
                    name = "conceal_lines";
                  }
                ];
              };
            };
            anti_conceal = {
              enabled = true;
              disabled_modes = false;
              above = 0;
              below = 0;
              ignore = {
                code_background = true;
                indent = true;
                sign = true;
                virtual_lines = true;
              };
            };
            padding = {
              highlight = "Normal";
            };
            latex = {
              enabled = false; # Disabled to resolve :checkhealth warnings
            };
            #on = {
            #  attach = ''
            #    function() end
            #  '';
            #  initial = ''
            #    function() end
            #  '';
            #  render = ''
            #    function() end
            #  '';
            #  clear = ''
            #    function() end
            #  '';
            #};
            #completions = {
            #  blink = {enabled = false;};
            #  coq = {enabled = false;};
            #  lsp = {enabled = false;};
            #  filter = {
            #    callout = ''
            #      function()
            #        return true
            #      end
            #    '';
            #    checkbox = ''
            #      function()
            #        return true
            #      end
            #    '';
            #  };
            #};
            heading = {
              enabled = true;
              render_modes = false;
              atx = true;
              setext = true;
              sign = true;
              icons = ["󰲡 " "󰲣 " "󰲥 " "󰲧 " "󰲩 " "󰲫 "];
              position = "overlay";
              signs = ["󰫎 "];
              width = "full";
              left_margin = 0;
              left_pad = 0;
              right_pad = 0;
              min_width = 0;
              border = false;
              border_virtual = false;
              border_prefix = false;
              above = "▄";
              below = "▀";
              backgrounds = [
                "RenderMarkdownH1Bg"
                "RenderMarkdownH2Bg"
                "RenderMarkdownH3Bg"
                "RenderMarkdownH4Bg"
                "RenderMarkdownH5Bg"
                "RenderMarkdownH6Bg"
              ];
              foregrounds = [
                "RenderMarkdownH1"
                "RenderMarkdownH2"
                "RenderMarkdownH3"
                "RenderMarkdownH4"
                "RenderMarkdownH5"
                "RenderMarkdownH6"
              ];
              custom = {};
            };
            paragraph = {
              enabled = true;
              render_modes = false;
              left_margin = 0;
              indent = 0;
              min_width = 0;
            };
            code = {
              enabled = true;
              render_modes = false;
              sign = true;
              conceal_delimiters = true;
              language = true;
              position = "left";
              language_icon = true;
              language_name = true;
              language_info = true;
              language_pad = 0;
              disable_background = ["diff"];
              width = "full";
              left_margin = 0;
              left_pad = 0;
              right_pad = 0;
              min_width = 0;
              border = "hide";
              language_border = "█";
              language_left = "";
              language_right = "";
              above = "▄";
              below = "▀";
              inline = true;
              inline_left = "";
              inline_right = "";
              inline_pad = 0;
              highlight = "RenderMarkdownCode";
              highlight_info = "RenderMarkdownCodeInfo";
              highlight_language = null;
              highlight_border = "RenderMarkdownCodeBorder";
              highlight_fallback = "RenderMarkdownCodeFallback";
              highlight_inline = "RenderMarkdownCodeInline";
              style = "full";
            };
            dash = {
              enabled = true;
              render_modes = false;
              icon = "─";
              width = "full";
              left_margin = 0;
              highlight = "RenderMarkdownDash";
            };
            document = {
              enabled = true;
              render_modes = false;
              conceal = {
                char_patterns = {};
                line_patterns = {};
              };
            };
            bullet = {
              enabled = true;
              render_modes = false;
              icons = ["●" "○" "◆" "◇"];
              ordered_icons = ''
                function(ctx)
                  local value = vim.trim(ctx.value)
                  local index = tonumber(value:sub(1, #value - 1))
                  return ('%d.'):format(index > 1 and index or ctx.index)
                end
              '';
              left_pad = 0;
              right_pad = 0;
              highlight = "RenderMarkdownBullet";
              scope_highlight = {};
            };
            checkbox = {
              enabled = true;
              render_modes = false;
              bullet = false;
              right_pad = 1;
              unchecked = {
                icon = "󰄱 ";
                highlight = "RenderMarkdownUnchecked";
                scope_highlight = null;
              };
              checked = {
                icon = "󰱒 ";
                highlight = "RenderMarkdownChecked";
                scope_highlight = null;
              };
              custom = {
                todo = {
                  raw = "[-]";
                  rendered = "󰥔 ";
                  highlight = "RenderMarkdownTodo";
                  scope_highlight = null;
                };
              };
            };
            quote = {
              enabled = true;
              render_modes = false;
              icon = "▋";
              repeat_linebreak = false;
              highlight = [
                "RenderMarkdownQuote1"
                "RenderMarkdownQuote2"
                "RenderMarkdownQuote3"
                "RenderMarkdownQuote4"
                "RenderMarkdownQuote5"
                "RenderMarkdownQuote6"
              ];
            };
            pipe_table = {
              enabled = true;
              render_modes = false;
              preset = "none";
              cell = "padded";
              #cell_offset = ''
              #  function()
              #    return 0
              #  end
              #'';
              padding = 1;
              min_width = 0;
              border = [
                "┌"
                "┬"
                "┐"
                "├"
                "┼"
                "┤"
                "└"
                "┴"
                "┘"
                "│"
                "─"
              ];
              border_enabled = true;
              border_virtual = false;
              alignment_indicator = "━";
              head = "RenderMarkdownTableHead";
              row = "RenderMarkdownTableRow";
              filler = "RenderMarkdownTableFill";
              style = "full";
            };
            callout = {
              note = {
                raw = "[!NOTE]";
                rendered = "󰋽 Note";
                highlight = "RenderMarkdownInfo";
                category = "github";
              };
              tip = {
                raw = "[!TIP]";
                rendered = "󰌶 Tip";
                highlight = "RenderMarkdownSuccess";
                category = "github";
              };
              important = {
                raw = "[!IMPORTANT]";
                rendered = "󰅾 Important";
                highlight = "RenderMarkdownHint";
                category = "github";
              };
              warning = {
                raw = "[!WARNING]";
                rendered = "󰀪 Warning";
                highlight = "RenderMarkdownWarn";
                category = "github";
              };
              caution = {
                raw = "[!CAUTION]";
                rendered = "󰳦 Caution";
                highlight = "RenderMarkdownError";
                category = "github";
              };
              abstract = {
                raw = "[!ABSTRACT]";
                rendered = "󰨸 Abstract";
                highlight = "RenderMarkdownInfo";
                category = "obsidian";
              };
              summary = {
                raw = "[!SUMMARY]";
                rendered = "󰨸 Summary";
                highlight = "RenderMarkdownInfo";
                category = "obsidian";
              };
              tldr = {
                raw = "[!TLDR]";
                rendered = "󰨸 Tldr";
                highlight = "RenderMarkdownInfo";
                category = "obsidian";
              };
              info = {
                raw = "[!INFO]";
                rendered = "󰋽 Info";
                highlight = "RenderMarkdownInfo";
                category = "obsidian";
              };
              todo = {
                raw = "[!TODO]";
                rendered = "󰗡 Todo";
                highlight = "RenderMarkdownInfo";
                category = "obsidian";
              };
              hint = {
                raw = "[!HINT]";
                rendered = "󰌶 Hint";
                highlight = "RenderMarkdownSuccess";
                category = "obsidian";
              };
              success = {
                raw = "[!SUCCESS]";
                rendered = "󰄬 Success";
                highlight = "RenderMarkdownSuccess";
                category = "obsidian";
              };
              check = {
                raw = "[!CHECK]";
                rendered = "󰄬 Check";
                highlight = "RenderMarkdownSuccess";
                category = "obsidian";
              };
              done = {
                raw = "[!DONE]";
                rendered = "󰄬 Done";
                highlight = "RenderMarkdownSuccess";
                category = "obsidian";
              };
              question = {
                raw = "[!QUESTION]";
                rendered = "󰘥 Question";
                highlight = "RenderMarkdownWarn";
                category = "obsidian";
              };
              help = {
                raw = "[!HELP]";
                rendered = "󰘥 Help";
                highlight = "RenderMarkdownWarn";
                category = "obsidian";
              };
              faq = {
                raw = "[!FAQ]";
                rendered = "󰘥 Faq";
                highlight = "RenderMarkdownWarn";
                category = "obsidian";
              };
              attention = {
                raw = "[!ATTENTION]";
                rendered = "󰀪 Attention";
                highlight = "RenderMarkdownWarn";
                category = "obsidian";
              };
              failure = {
                raw = "[!FAILURE]";
                rendered = "󰅖 Failure";
                highlight = "RenderMarkdownError";
                category = "obsidian";
              };
              fail = {
                raw = "[!FAIL]";
                rendered = "󰅖 Fail";
                highlight = "RenderMarkdownError";
                category = "obsidian";
              };
              missing = {
                raw = "[!MISSING]";
                rendered = "󰅖 Missing";
                highlight = "RenderMarkdownError";
                category = "obsidian";
              };
              danger = {
                raw = "[!DANGER]";
                rendered = "󱐌 Danger";
                highlight = "RenderMarkdownError";
                category = "obsidian";
              };
              error = {
                raw = "[!ERROR]";
                rendered = "󱐌 Error";
                highlight = "RenderMarkdownError";
                category = "obsidian";
              };
              bug = {
                raw = "[!BUG]";
                rendered = "󰨰 Bug";
                highlight = "RenderMarkdownError";
                category = "obsidian";
              };
              example = {
                raw = "[!EXAMPLE]";
                rendered = "󰉹 Example";
                highlight = "RenderMarkdownHint";
                category = "obsidian";
              };
              quote = {
                raw = "[!QUOTE]";
                rendered = "󱆨 Quote";
                highlight = "RenderMarkdownQuote";
                category = "obsidian";
              };
              cite = {
                raw = "[!CITE]";
                rendered = "󱆨 Cite";
                highlight = "RenderMarkdownQuote";
                category = "obsidian";
              };
            };
            link = {
              enabled = true;
              render_modes = false;
              footnote = {
                enabled = true;
                superscript = true;
                prefix = "";
                suffix = "";
              };
              image = "󰥶 ";
              email = "󰀓 ";
              hyperlink = "󰌹 ";
              highlight = "RenderMarkdownLink";
              wiki = {
                icon = "󱗖 ";
                #body = ''
                #  function()
                #    return nil
                #  end
                #'';
                highlight = "RenderMarkdownWikiLink";
                scope_highlight = null;
              };
              custom = {
                web = {
                  pattern = "^http";
                  icon = "󰖟 ";
                };
                discord = {
                  pattern = "discord%.com";
                  icon = "󰙯 ";
                };
                github = {
                  pattern = "github%.com";
                  icon = "󰊤 ";
                };
                gitlab = {
                  pattern = "gitlab%.com";
                  icon = "󰮠 ";
                };
                google = {
                  pattern = "google%.com";
                  icon = "󰊭 ";
                };
                neovim = {
                  pattern = "neovim%.io";
                  icon = " ";
                };
                reddit = {
                  pattern = "reddit%.com";
                  icon = "󰑍 ";
                };
                stackoverflow = {
                  pattern = "stackoverflow%.com";
                  icon = "󰓌 ";
                };
                wikipedia = {
                  pattern = "wikipedia%.org";
                  icon = "󰖬 ";
                };
                youtube = {
                  pattern = "youtube%.com";
                  icon = "󰗃 ";
                };
              };
            };
            sign = {
              enabled = true;
              highlight = "RenderMarkdownSign";
            };
            inline_highlight = {
              enabled = true;
              render_modes = false;
              highlight = "RenderMarkdownInlineHighlight";
            };
            indent = {
              enabled = false;
              render_modes = false;
              per_level = 2;
              skip_level = 1;
              skip_heading = false;
              icon = "▎";
              priority = 0;
              highlight = "RenderMarkdownIndent";
            };
            html = {
              enabled = true;
              render_modes = false;
              comment = {
                conceal = true;
                text = null;
                highlight = "RenderMarkdownHtmlComment";
              };
              tag = {};
            };
            win_options = {
              conceallevel = {
                default = "vim.o.conceallevel";
                rendered = 3;
              };
              concealcursor = {
                default = "vim.o.concealcursor";
                rendered = "";
              };
            };
            overrides = {
              buflisted = {};
              buftype = {
                nofile = {
                  render_modes = true;
                  padding = {highlight = "NormalFloat";};
                  sign = {enabled = false;};
                };
              };
              filetype = {};
            };
            custom_handlers = {};
            #yaml = {
            #  enabled = true;
            #  render_modes = false;
            #};
          };
        };
      };

      # Languages that are enabled in the maximal configuration.
      bash.enable = true;
      clang.enable = true;
      css.enable = true;
      html.enable = true;
      sql.enable = true;
      java.enable = true;
      kotlin.enable = true;
      ts.enable = true;
      go.enable = true;
      lua.enable = true;
      zig.enable = true;
      python.enable = true;
      typst.enable = true;
      rust = {
        enable = true;
        crates.enable = true;
      };

      # Language modules that are not as common.
      assembly.enable = false;
      astro.enable = false;
      nu.enable = false;
      csharp.enable = false;
      julia.enable = false;
      vala.enable = false;
      scala.enable = false;
      r.enable = false;
      gleam.enable = false;
      dart.enable = false;
      ocaml.enable = false;
      elixir.enable = false;
      haskell.enable = false;
      ruby.enable = false;
      fsharp.enable = false;

      tailwind.enable = false;
      svelte.enable = false;

      # Nim LSP is broken on Darwin and therefore
      # should be disabled by default. Users may still enable
      # `vim.languages.vim` to enable it, this does not restrict
      # that.
      # See: <https://github.com/PMunch/nimlsp/issues/178#issue-2128106096>
      nim.enable = false;
    };

    visuals = {
      nvim-scrollbar.enable = true;
      nvim-web-devicons.enable = true;
      nvim-cursorline.enable = true;
      cinnamon-nvim.enable = true;
      fidget-nvim.enable = true;

      highlight-undo.enable = true;
      indent-blankline.enable = true;

      # Fun
      cellular-automaton.enable = false;
    };

    statusline = {
      lualine = {
        enable = true;
        theme = "catppuccin";
      };
    };

    theme = {
      enable = true;
      name = "catppuccin";
      style = "mocha";
      transparent = false;
    };

    autopairs.nvim-autopairs.enable = true;

    # nvf provides various autocomplete options. The tried and tested nvim-cmp
    # is enabled in default package, because it does not trigger a build. We
    # enable blink-cmp in maximal because it needs to build its rust fuzzy
    # matcher library.
    autocomplete = {
      nvim-cmp.enable = !true;
      blink-cmp.enable = true;
    };

    snippets.luasnip.enable = true;

    filetree = {
      neo-tree = {
        enable = true;
      };
    };

    tabline = {
      nvimBufferline.enable = true;
    };

    treesitter.context.enable = true;

    binds = {
      whichKey.enable = true;
      cheatsheet.enable = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>?";
        action = ":Cheatsheet<CR>";
      }
      {
        mode = "n";
        key = "<leader>e";
        action = ":Neotree toggle<CR>";
      }
    ];

    telescope.enable = true;

    git = {
      enable = true;
      gitsigns.enable = true;
      gitsigns.codeActions.enable = false; # throws an annoying debug message
      neogit.enable = true;
    };

    minimap = {
      minimap-vim.enable = false;
      codewindow.enable = true; # lighter, faster, and uses lua for configuration
    };

    dashboard = {
      dashboard-nvim.enable = false;
      alpha.enable = true;
    };

    notify = {
      nvim-notify.enable = true;
    };

    projects = {
      project-nvim.enable = true;
    };

    utility = {
      ccc.enable = false;
      vim-wakatime.enable = false;
      diffview-nvim.enable = true;
      yanky-nvim.enable = false;
      icon-picker.enable = true;
      surround.enable = true;
      leetcode-nvim.enable = true;
      multicursors.enable = true;
      smart-splits.enable = true;
      undotree.enable = true;
      nvim-biscuits.enable = true;

      motion = {
        hop.enable = true;
        leap.enable = true;
        precognition.enable = true;
      };
      images = {
        image-nvim.enable = false;
        img-clip.enable = true;
      };
    };

    notes = {
      obsidian.enable = false; # FIXME: neovim fails to build if obsidian is enabled
      neorg.enable = false;
      orgmode.enable = false;
      mind-nvim.enable = true;
      todo-comments.enable = true;
    };

    terminal = {
      toggleterm = {
        enable = true;
        lazygit.enable = true;
      };
    };

    ui = {
      borders.enable = true;
      noice.enable = true;
      colorizer.enable = true;
      modes-nvim.enable = false; # the theme looks terrible with catppuccin
      illuminate.enable = true;
      breadcrumbs = {
        enable = true;
        navbuddy.enable = true;
      };
      smartcolumn = {
        enable = true;
        setupOpts.custom_colorcolumn = {
          # this is a freeform module, it's `buftype = int;` for configuring column position
          nix = "110";
          ruby = "120";
          java = "130";
          go = ["90" "130"];
        };
      };
      fastaction.enable = true;
    };

    assistant = {
      chatgpt.enable = false;
      copilot = {
        enable = false;
        cmp.enable = true;
      };
      codecompanion-nvim.enable = false;
      avante-nvim.enable = true;
    };

    session = {
      nvim-session-manager.enable = false;
    };

    gestures = {
      gesture-nvim.enable = false;
    };

    comments = {
      comment-nvim.enable = true;
    };

    presence = {
      neocord.enable = false;
    };
  };
}
