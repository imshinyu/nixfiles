{ config, ...}:
{
  xdg.configFile."qtengine".source =
    config.lib.file.mkOutOfStoreSymlink "/home/shinyu/nixfiles/configs/qtengine";
}
