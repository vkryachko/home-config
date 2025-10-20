{ pkgs, ... }:
let
  hm-location = "/Users/vkryachko/.config/home-manager";
in
{
  programs.helix = {
    enable = true;
    extraPackages = [
      pkgs.vscode-json-languageserver
      pkgs.nixfmt
    ];
    settings = {
      theme = "dark_plus";

      keys.normal = {
        D = [
          "ensure_selections_forward"
          "extend_to_line_end"
          "delete_selection"
        ];
        C = [
          "ensure_selections_forward"
          "extend_to_line_end"
          "change_selection"
        ];
      };

      editor = {
        color-modes = true;
        cursorline = true;
        bufferline = "always";
        end-of-line-diagnostics = "hint";

        auto-save.after-delay = {
          enable = true;
          timeout = 1000;
        };

        file-picker.hidden = false;

        inline-diagnostics.cursor-line = "warning";

        lsp.display-inlay-hints = true;

        cursor-shape.insert = "bar";

        whitespace.render = {
          space = "all";
          tab = "all";
        };

        indent-guides.render = true;
      };
    };
    languages = {
      language-server = {
        rust-analyzer = {
          command = "${pkgs.rust-analyzer}/bin/rust-analyzer";
          config = {
            check.command = "clippy";
          };
        };
        nixd = {
          command = "${pkgs.nixd}/bin/nixd";
          formatting.command = "nixfmt";
          nixpkgs.expr = ''import (builtins.getFlake "${hm-location}").inputs.nixpkgs {}'';
          options.nixos.expr = "{}";
          options.home-manager.expr = ''(builtins.getFlake "${hm-location}").homeConfigurations.vkryachko.options'';
        };
      };
      language = [
        {
          name = "nix";
          auto-format = true;
          language-servers = [
            "nixd"
          ];
          formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
        }
      ];
    };
  };
}
