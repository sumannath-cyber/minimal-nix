{ pkgs, ... }:

{
  home.username = "suman";
  home.homeDirectory = "/home/suman";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  # Wofi is needed by Hyprland's default Super+R app launcher bind
  home.packages = with pkgs; [
    wofi
  ];

  # Kitty Terminal
  programs.kitty.enable = true;

  # Neovim Editor
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
}
