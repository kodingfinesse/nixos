{ config, pkgs, stdenv, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  # Bootloader.
  boot.kernelPackages = pkgs.linuxPackages_latest_xen_dom0;
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev"; # or "nodev" for efi only
  boot.supportedFilesystems = [ "ntfs" ];
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "nixos"; # Define your hostname.
#  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # services 
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.wayland = false;
  # services.dbus.packages = with pkgs; [ pkgs.gnome3.dconf ];
  # services.udev.packages = with pkgs; [ pkgs.gnome3.gnome-settings-daemon ];

  # Enable networking
  networking.networkmanager.enable = true;
  nixpkgs.config.allowBroken = true;
  systemd.services.NetworkManager-wait-online.enable = false;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
  # programs.home-manager.enable = true;
  # home-manager.users.darren = { pkgs, ... }: {
  #   home.packages = [ pkgs.atool pkgs.httpie ];
  #   programs.bash.enable = true;
  # };
  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

# Configure keymap in X11
  services.xserver = {
    layout = "us";
    };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
    };

  services.flatpak.enable = true;

  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
    };
  };
  programs.zsh.ohMyZsh = {
         enable = true;
         plugins = [ "git" "python" "man" "sudo" "z" "fzf" "autojump" "autopep8" "zsh-autosuggestions" "zsh-syntax-highlighting" "history" ];
         theme = "agnoster";
     };
  

  services.xserver.libinput.enable = true;

  users.users.darren = {
    isNormalUser = true;
    description = "Darren Tran";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
     ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    gedit # text editor
    epiphany # web browser
    geary # email reader
    evince # document viewer
    gnome-characters
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]);
  
  environment.systemPackages = with pkgs; [
     google-chrome-beta
     cifs-utils
     libreoffice-fresh
     firefox
     thunderbird
     joplin-desktop
     vscode-with-extensions
     vscode-extensions.redhat.java
     nodenv
     python39
     pipenv
     spotify
     slack
     zoom-us
     discord
     openshot-qt
     flatpak
     fwupd
     packagekit
     nomacs
     flatpak
     zsh
     zsh-z
     zsh-history
     zsh-fzf-tab
     zsh-autoenv
     zsh-autopair
     zsh-nix-shell
     zsh-completions
     zsh-git-prompt
     zsh-powerlevel10k
     zsh-command-time
     zsh-autocomplete
     zsh-autosuggestions
     zsh-navigation-tools
     zsh-syntax-highlighting
     zsh-better-npm-completion
     zsh-history-substring-search
     zsh-fast-syntax-highlighting
     zinit
     any-nix-shell
     nix-zsh-completions
     oh-my-zsh
     zsh-history-search-multi-word
     zsh-you-should-use
     fzf-zsh
     ccache
     nodenv
     python39
     pipenv
     nodePackages_latest.npm
     curl
     wget
     sudo
     nano
     git
     gitui
     rpi-imager
     bottles
     variety
     guake
     gnomeExtensions.user-themes
     gnome.gnome-themes-extra
     xdg-desktop-portal-gnome
     vimix-gtk-themes
     gnomeExtensions.arcmenu
     gnomeExtensions.dash-to-panel
     gnomeExtensions.dash-to-dock
     gnomeExtensions.vitals
     pkgs.gnome3.gnome-tweaks
     gnome.gnome-terminal
     neofetch
     autojump
     fzf
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 80 ];
  networking.firewall.allowedUDPPorts = [ 443 ];

  system.stateVersion = "22.11";
