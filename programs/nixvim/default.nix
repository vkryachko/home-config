{ lib, ... }:
let
  inherit (builtins) readDir;
  inherit (lib) flatten hasSuffix mapAttrsToList;

  # Finds immediate child nix files of a directory plus nix files in
  # immediate child folders, does not go deeper.
  findPlugins =
    base-dir:
    let
      contents = readDir base-dir;
      mapped = mapAttrsToList (
        k: v:
        let
          child = base-dir + "/${k}";
        in
        if v != "directory" && hasSuffix ".nix" k then
          [ child ]
        else
          mapAttrsToList (k: _: child + "/${k}") (readDir child)
      ) contents;
    in
    flatten mapped;
in
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    imports = [
      ./opts.nix
      ./keymappings.nix
      ./auto_cmds.nix
      ./colors.nix
    ]
    ++ findPlugins ./plugins;
  };
}
