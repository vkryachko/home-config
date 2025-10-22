{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      # power-theme
      tokyo-night-tmux
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

}
