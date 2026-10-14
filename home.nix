{ config, pkgs, ... }:

{
  home.username = "suman";
  home.homeDirectory = "/home/suman";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    kitty
    firefox
    thunar
    neovim
    git
  ];

  programs.bash.enable = true;
  programs.git.enable = true;

  programs.home-manager.enable = true;
}
