{ pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Bootloader (systemd-boot for UEFI)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Hostname & Networking
  networking.hostName = "notNix";
  networking.networkmanager.enable = true;

  # Timezone & Locale
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable Flakes & Unfree Packages
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # Hyprland & SDDM Display Manager
  programs.hyprland.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Audio (PipeWire)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Graphics & Hardware Video Acceleration (Intel 6th Gen Skylake)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver # VA-API (iHD) for Skylake (Gen 9)
      libvdpau-va-gl
    ];
  };

  # User Account
  users.users.suman = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
  };

  # Essential System Packages
  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
    wl-clipboard
    libva-utils # Provides vainfo to verify hardware video acceleration
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    LIBVA_DRIVER_NAME = "iHD";
  };

  system.stateVersion = "26.05";
}
