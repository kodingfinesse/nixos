{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev"; # or "nodev" for efi only
  boot.supportedFilesystems = [ "ntfs" ];
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  nixpkgs.config.allowBroken = true;

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

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
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

  # flatpak
  services.flatpak.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # oh my zsh
  # {
  #   programs.zsh.ohMyZsh = {
  #       enable = true;
  #       plugins = [ "git" "python" "man" "sudo" ];
  #       theme = "agnoster";
  #   };
  # }

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.darren = {
    isNormalUser = true;
    description = "Darren Tran";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
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
     nomacs
     gnome-text-editor
     gnome.gnome-calculator
     gnome.gnome-calendar
     libsForQt514.dolphin
     libsForQt514.discover
     libsForQt514.okular
     libsForQt514.konsole
     kde-gruvbox
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
     haveged
     bluez
     bluez-alsa
     bluez5-experimental
     blueman
     cups
     hplip
     sshs
     sshfs
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
     plank
     latte-dock
     yakuake
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 80 ];
  networking.firewall.allowedUDPPorts = [ 443 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}
