{ config, pkgs, ... }:
{
  users.users.serverUser = {
    isNormalUser = true;
    description  = "Home Server User";
    home         = "/home/server";
    extraGroups  = [ "wheel" "storage" ];
    # hashedPassword or password
    password     = "nixos";
  };
}
