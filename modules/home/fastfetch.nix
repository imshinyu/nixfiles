{ config, ...}:
{
  xdg.configFile."fastfetch".source =
    config.lib.file.mkOutOfStoreSymlink "/home/shinyu/nixfiles/configs/fastfetch";
}
