{ config, ...}:
{
  xdg.configFile."helix".source =
    config.lib.file.mkOutOfStoreSymlink "/home/shinyu/nixfiles/configs/helix";
}
