{ config, pkgs, inputs, ... }:
{
  environment.sessionVariables = rec {
    XDG_CACHE_HOME    = "$HOME/.cache";
    XDG_CONFIG_HOME   = "$HOME/.config";
    XDG_DATA_HOME     = "$HOME/.local/share";
    XDG_STATE_HOME    = "$HOME/.local/state";
    XCOMPOSECACHE     = "$XDG_CACHE_HOME/X11/xcompose";
    CARGO_HOME        = "$XDG_DATA_HOME/cargo";
    RUSTUP_HOME       = "$XDG_DATA_HOME/rustup";
    GTK2_RC_FILES     = "$XDG_CONFIG_HOME/gtk-2.0/gtkrc";
    HISTFILE          = "$XDG_STATE_HOME/bash/history";
    ANDROID_USER_HOME = "$XDG_DATA_HOME/android";
    ANDROID_HOME      = "$XDG_DATA_HOME/android/sdk";
    # Not officially in the specification
    XDG_BIN_HOME      = "$HOME/.local/bin";
    QT_QPA_PLATFORMTHEME = "qtengine";
    PATH = [ 
      "${XDG_BIN_HOME}"
    ];
  };
  environment.variables = {
    ROC_ENABLE_PRE_VEGA = "1";
  };
}
