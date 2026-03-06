{ config, ...}:
{
  xdg.configFile."matugen".source =
    config.lib.file.mkOutOfStoreSymlink "/home/shinyu/nixfiles/configs/matugen";
}
