{
  lib,
  pkgs,
  ...
}: {
  ###################################################################################
  #
  #  NixOS's core configuration suitable for all my machines
  #  https://github.com/ryan4yin/nix-config/blob/c515ea98077612a3ec4576ab5257af26ceed6bc2/modules/nixos/core-server.nix
  #
  ###################################################################################

  # for nix server, we do not need to keep too much generations
  
  # TODO enable
  #boot.loader.systemd-boot.configurationLimit = lib.mkDefault 10;
  # boot.loader.grub.configurationLimit = 10;
  # do garbage collection weekly to keep disk usage low
  
  # TODO enable
  #nix.gc = {
  #  automatic = lib.mkDefault true;
  #  dates = lib.mkDefault "weekly";
  #  options = lib.mkDefault "--delete-older-than 1w";
  #};

  nix.settings = {
    # Manual optimise storage: nix-store --optimise
    # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store

    # TODO enable
    #auto-optimise-store = true;

    # TODO enable
    #builders-use-substitutes = true;
    # enable flakes globally
    experimental-features = ["nix-command" "flakes"];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = lib.mkDefault false;

  
  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };
  
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.

  # TODO enable  
  #networking.firewall.enable = lib.mkDefault false;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no"; # disable root login
      PasswordAuthentication = false; # disable password login
    };
    openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    keepassxc
    git
    nano
    wget
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  ];
  environment.variables.EDITOR = "nano";
  

  #virtualisation.docker = {
  #  enable = true;
  #  # start dockerd on boot.
  #  # This is required for containers which are created with the `--restart=always` flag to work.
  #  enableOnBoot = true;
  #};
}
