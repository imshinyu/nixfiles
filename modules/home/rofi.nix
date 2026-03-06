{ config, ...}:
{
  xdg.configFile."rofi".source =
    config.lib.file.mkOutOfStoreSymlink "/home/shinyu/nixfiles/configs/rofi";
}
