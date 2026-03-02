{config, lib, pkgs, inputs, ...}:
{
  services.printing.enable = true;
  services.printing.drivers = [
    pkgs.cups-filters
    pkgs.cnijfilter2
    pkgs.gutenprint
  ];
}
