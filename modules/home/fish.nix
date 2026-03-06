{ config, ...}:
{
  xdg.configFile."fish".source =
    config.lib.file.mkOutOfStoreSymlink "/home/shinyu/nixfiles/configs/fish";
}
