{ config, ...}:
{
  xdg.configFile."gtk-3.0".source =
    config.lib.file.mkOutOfStoreSymlink "/home/shinyu/nixfiles/configs/gtk-3.0";
  xdg.configFile."gtk-4.0".source =
    config.lib.file.mkOutOfStoreSymlink "/home/shinyu/nixfiles/configs/gtk-4.0";
}
