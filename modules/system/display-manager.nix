{ config, lib, pkgs, inputs, ... }:
{
  # services.displayManager.gdm.enable = true;
  # services.accounts-daemon.enable = true;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        # command = "${pkgs.tuigreet}/bin/tuigreet --user-menu --remember --remember-user-session --time --cmd ${pkgs.labwc}";
        # command = "${inputs.niri.packages.${pkgs.system}.niri}/bin/niri --config /var/lib/greetd/niri/config.kdl";
        command = "${inputs.mango.packages.${pkgs.system}.mango}/bin/mango -s '${pkgs.quickshell}/bin/qs -p /home/shinyu/nixfiles/assets/config/quickshell/greetd/shell.qml'";
        user = "greeter";
      };
    };
  };
  users.users.greeter.extraGroups = [ "video" "input" ];
  # services.greetd.useTextGreeter = true;
  
  # services.displayManager.ly = {
  #   enable = true;
  #   settings = {
  #     # allow_empty_password = false; # dangerous?
  #     animation = "colormix"; # "doom", "matrix", "colormix"
  #     animation_timeout_sec = 300; # 5 minutes
  #     bg = "0x02000000";
  #     # bigclock = "en"; # enlarges the clock -- may not work with some fonts?
  #     # blank_box = false; # transparent
  #     border_fg = "0x01FFFFFF";
  #     clear_password = true;
  #     clock = "%B, %A %d @ %H:%M:%S";
  #     colormix_col1 = "0x20000000";
  #     colormix_col2 = "0x200C0C0C";
  #     colormix_col3 = "0x20FFFFFF";
  #     default_input = "password";
  #     error_bg = "0x02000000";
  #     error_fg = "0x01FF0000";
  #     fg = "0x01FFFFFF";
  #     hide_borders = false;
  #     hide_version_string = true; # doesnt work?
  #     hide_key_hints = true;
  #     initial_info_text = "null"; # hostname
  #     # input_len = 69;
  #     lang = "en";
  #     load = true;
  #     margin_box_h = 0;
  #     margin_box_v = 0;
  #     min_refresh_delta = 100; # milliseconds -- default=5
  #     numlock = true;
  #     save = true;
  #     text_in_center = false; # ugly
  #     # tty = 4; # broken? -- could help with UWSM sessions
  #     # vi_default_mode = "insert";
  #     # vi_mode = true;
  #     # ...
  #   };
  # };
}

