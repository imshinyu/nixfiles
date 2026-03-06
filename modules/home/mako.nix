{ config, ...}:
{
  xdg.configFile."mako".source =
    config.lib.file.mkOutOfStoreSymlink "/home/shinyu/nixfiles/configs/mako";
}
