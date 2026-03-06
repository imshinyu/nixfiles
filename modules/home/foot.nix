{ config, ...}:
{
  xdg.configFile."foot".source =
    config.lib.file.mkOutOfStoreSymlink "/home/shinyu/nixfiles/configs/foot";
}
