{ pkgs, ... }:
{
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      vhostUserPackages = [ pkgs.virtiofsd ];
    };
  };

  programs.virt-manager = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    dnsmasq
  ];

  networking.firewall.trustedInterfaces = [ "virbr0" ];
}
