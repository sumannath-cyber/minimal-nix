{ config, pkgs, lib, unstable, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Host
  networking.hostName = "idk-nix";
  networking.networkmanager.enable = true;

  # Time
  time.timeZone = "Asia/Kolkata";

  # User
  users.users.suman = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
  };

  # X + Wayland base
  services.xserver.enable = true;

  # Hyprland (stable base)
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Minimal display manager
  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "hyprland";

  # Portals
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-hyprland
  ];

  # Audio
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };

  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11";
}
