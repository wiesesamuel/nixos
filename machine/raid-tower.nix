{ config, pkgs, ... }:
{
  # https://gist.github.com/Zaczero/e8294242b2c3dd5dc1c4303637a6d244
  boot.initrd.supportRaid = true;

  mdadm.arrays."md0".devices = [
    "/dev/sda"
    "/dev/sdb"
  ];

  fileSystems."/raid" = {
    device = "/dev/md0";
    fsType = "ext4";
  };
}
