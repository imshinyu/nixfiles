{ config, ...}:
{
  xdg.configFile."niri".source =
    config.lib.file.mkOutOfStoreSymlink "/home/shinyu/nixfiles/configs/niri";
}
