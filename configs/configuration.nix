{ config, pkgs, ... }:

{
  imports =
    [ # hardware-configuration nie istnieje ale niech zostanie ze niby ogarniete jestes
    #wez to posegreguj przzyszly ja

      ./hardware-configuration.nix
      ./packages.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
#zmien na gruba japierodle ale tu syf
  networking.hostName = "Linuz"; # nazwa kompa w sieci

#monitor setting rozdzialka
  monitor = [
   "DP-1, 1920x1080, 0x0, 1"
];

  # siec 
  networking.networkmanager.enable = true;

  # Strefa czasowa zmien na srodkowo europejski cepie Yugoslavia nie istnieje
  time.timeZone = "Europe/Sarajevo";

  # archive mirror jebnij komuchom po serwerach
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

  # tylko wayland cipy
  #services.sddm.enable = true;

      services.xserver.displayManager.sddm.enable = true; 
      services.xserver.displayManager.gdm.wayland.enable = true;
     #wez to wjeb do osobnego pliku ale zmien wartoschi sha256 i variables
  
  #hyprland jako tiling i chuj 
  #programs.hyprland.enable = true
  
  # Enable the KDE Plasma Desktop Environment.
  #services.displayManager.sddm.enable = true;
  #services.xserver.desktopManager.plasma5.enable = true;

#do zrobienie wyjebac x11 z dm zastap wayland
  # Configure keymap in X11
  #services.xserver.xkb = {
    #layout = "pl";
    #variant = "";
  };

  # lepsze nie dworjak 
  # do zdrobienia remap caps to esc
  #console.keyMap = "pl2";

  input {
  kb_layout = pl
  kb_variant =
  kb_model =
  kb_options = caps:escape
  kb_rules =
  repeat_rate = 50
  repeat_delay = 300

  # jestes drukarka harry
  services.printing.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # lepiej se variable ustaw debilu jebany
  users.users.jabaldoo = {
    isNormalUser = true;
    description = "jabaldoo";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kate
      nvim
    ];
  }

  # Enable Flatpak


  services.flatpak.enable = true;

  # Install Firefox
  #programs.firefox.enable = true;
  #spieprzac z firefoxe szpiedzy jebany

  programs.brave.enable = true

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  # Enable Bluetooth
  hardware.bluetooth.enable = true;
  
  # wyjebac tlp tylko baternie niszczy
  services.power-profiles-daemon.enable = false;

  # optymalizacja bateri niby dziala ale lepiej nie 
  #services.tlp.enable = true;

  #hardware specyfiki do lapka ustaw se jakis
  hardware.enableRedistributableFirmware = true;  # Enable non-free firmware for better hardware compatibility (e.g., wifi, bluetooth)

  
  system.stateVersion = "24.11"; # nieaktualne o rok chyba
}
