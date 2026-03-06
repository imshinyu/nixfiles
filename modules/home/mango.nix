{ config, ...}:
{
  xdg.configFile."mango".source =
    config.lib.file.mkOutOfStoreSymlink "/home/shinyu/nixfiles/configs/mango";
}
