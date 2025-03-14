{ config, pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.curl
    pkgs.htop
    pkgs.nginx
  ];
}
