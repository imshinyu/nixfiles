{ config, ...}:
{
  xdg.configFile."yazi".source =
    config.lib.file.mkOutOfStoreSymlink "/home/shinyu/nixfiles/configs/yazi";
}
