{ config, ...}:
{
  xdg.configFile."quickshell".source =
    config.lib.file.mkOutOfStoreSymlink "/home/shinyu/nixfiles/configs/quickshell";
}
