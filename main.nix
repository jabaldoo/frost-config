{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix  #  `sudo nixos-generate-config`
    ./packages.nix
  ];

  
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "Linuz";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Warsaw";  # Czas z centralnej europy
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "pl_PL.UTF-8";
      LC_MONETARY = "pl_PL.UTF-8";
      
    };
  };

  services.xserver = {
    enable = true;
    
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    
    xkb = {
      layout = "pl";
      variant = "";
      options = "caps:escape";
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  users.users.jabaldoo = {
    isNormalUser = true;
    description = "jabaldoo";
    extraGroups = [ "networkmanager" "wheel" "video" ];
    packages = with pkgs; [
      brave
      kate
      neovim
    ];
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.flatpak.enable = true;
  
  hardware = {
    bluetooth.enable = true;
    pulseaudio.enable = false;
  };

  services.power-profiles-daemon.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    git
    htop
  ];

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "23.11";  # Update to your actual NixOS version
}
