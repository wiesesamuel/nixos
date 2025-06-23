{ config, pkgs, ... }:

{
  home.username      = "homeserver";
  home.homeDirectory = "/home/homeserver";

  home.packages = with pkgs; [
    btop git radicale
  ];

  programs.git = {
    enable = true;
  }

  services.radicale = {
    enable = true;
    settings.server.hosts = [ "0.0.0.0:5232" ];
  };
}
