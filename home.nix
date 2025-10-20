{ pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "vkryachko";
  home.homeDirectory = "/Users/vkryachko";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # pkgs.nix
    pkgs.which
    pkgs.nixfmt
    pkgs.brave
    pkgs.nodejs
    pkgs.ripgrep

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionPath = [
    "$HOME/.nix-profile/bin"
    "$HOME/.nix-profile/share/man"
    "/nix/var/nix/profiles/default/bin"
  ];

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/vkryachko/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
  };

  programs = {
    nixvim = {
      enable = true;
      defaultEditor = true;
      imports = [ ./programs/nixvim ];
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
    nix-index.enable = true;
    nix-index-database.comma.enable = true;
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    git.enable = true;
    direnv.enable = true;
    bash.enable = true;
    starship.enable = true;
    man = {
      enable = true;
      # generateCaches = true;
    };
    tmux = {

      enable = true;
      plugins = with pkgs.tmuxPlugins; [
        power-theme
        vim-tmux-navigator
      ];
      shortcut = "a";
      baseIndex = 1;
      newSession = true;
      escapeTime = 0;
      mouse = true;
      clock24 = true;
      historyLimit = 50000;
      keyMode = "vi";
      customPaneNavigationAndResize = true;

      extraConfig = ''
        bind | split-window -h -c "#{pane_current_path}"
        bind - split-window -v -c "#{pane_current_path}"
        bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"
      '';
    };
  };

  imports = [
    ./helix.nix
  ];
}
