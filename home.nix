{ config, pkgs, unstable, ... }:

{
  home.username = "suman";
  home.homeDirectory = "/home/suman";
  home.stateVersion = "25.11";

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
