{ips, ...}: {
  services.nfs = {
    server = {
      enable = true;
      createMountPoints = true;
      exports = ''
        /srv/data *(rw,sync,no_subtree_check,crossmnt,fsid=0,root_squash)
      '';
      extraNfsdConfig = ''
        [nfsd]
        vers3=off
        vers4=yes
        udp=off
        tcp=on
      '';
    };
  };
  fileSystems."/srv/data" = {
    device = "/dev/disk/by-uuid/9014f510-b08e-488f-8c43-20a4ac7f15cc";
    fsType = "ext4";
    options = [
      "defaults"
      "nofail"
    ];
  };
}
