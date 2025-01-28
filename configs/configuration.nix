{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Sarajevo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "bs_BA.UTF-8";
    LC_IDENTIFICATION = "bs_BA.UTF-8";
    LC_MEASUREMENT = "bs_BA.UTF-8";
    LC_MONETARY = "bs_BA.UTF-8";
    LC_NAME = "bs_BA.UTF-8";
    LC_NUMERIC = "bs_BA.UTF-8";
    LC_PAPER = "bs_BA.UTF-8";
    LC_TELEPHONE = "bs_BA.UTF-8";
    LC_TIME = "bs_BA.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;


  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "pl2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with PipeWire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.racoon = {
    isNormalUser = true;
    description = "Racoon";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kate
      vim
    ];
  };

  # Install additional packages for the user
  environment.systemPackages = with pkgs; [
    obs-studio
    vscode
    discover
    git
    github-cli          # GitHub CLI
    github-desktop      # GitHub Desktop (GUI)
    obsidian
    cider
    discord
    arduino-ide
    flatpak 
    python3
    fastfetch
    cmatrix
    pipes
    cava
    sddm
    dropbox
    plasma-workspace
    kde-cli-tools
    kde-gtk-config
    rofi
    nmap
    wireshark
    sddm-kcm
    plasma-desktop
    krusader
  ];

  # Enable Flatpak
  services.flatpak.enable = true;

  # Install Firefox
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable Bluetooth
  hardware.bluetooth.enable = true;
  
  # Disable power-profiles-daemon to avoid conflicts with TLP
  services.power-profiles-daemon.enable = false;

  # Enable TLP for better power management (ThinkPad-specific)
  services.tlp.enable = true;

  # Enable ThinkPad-specific configurations
  hardware.enableRedistributableFirmware = true;  # Enable non-free firmware for better hardware compatibility (e.g., wifi, bluetooth)

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "24.11"; # Did you read the comment?
}

