if status is-interactive
    # Commands to run in interactive sessions can go here
end
#fish_config theme choose "Matugen"

alias qmlls="qmlls6"
alias rgcc="gcc -lraylib"
function jrun
    # Compiles the .java file passed as the first argument
    javac $argv[1]
    
    # If compilation succeeded, run the class (stripping the .java extension)
    if test $status -eq 0
        set -l class_name (string replace -r '\.java$' '' $argv[1])
        java $class_name
    end
end
alias rebuild="sudo nixos-rebuild switch --flake ~/nixfiles/"
export HSA_OVERRIDE_GFX_VERSION=8.0.3
export OLLAMA_VULKAN=1
export ROC_ENABLE_PRE_VEGA=1
set -g theme_color_scheme Matugen

# Created by `pipx` on 2025-11-09 19:10:06
set PATH $PATH ~/.local/bin
set PATH $PATH ~/.local/share/cargo/bin
set PATH $PATH ~/Applications
set PATH $PATH ~/Scripts
set PATH $PATH ~/.nix-profile/bin
set PATH $PATH $(go env GOPATH)/bin
set PATH $PATH .local/share/soar/bin
set -U fish_greeting
function fish_greeting
    echo "⠣⡻⣿⣿⣿⣿⣾⣫⣿⣿⣿⣵⣆⣤⣿⣿⣿⣿⣿⣿⣿⣿⣷⣾⣿⣿⢿⣿⣿⣧⠀⠉⣻⣿⣿⣏⣽⣿⣿⡿⡿⣿⣿⣷⣷⣿⣶⣿⣿⡿⢣⡿⣸⣾⣿⡿
⠀⠈⣻⠻⣿⣟⣿⣿⣿⣿⡋⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⢺⣻⣿⣿⣧⣴⣿⣿⣿⣿⣿⡿⣿⣿⡿⣿⣿⠿⠿⠟⠛⠋⠁⢤⣾⣵⣿⢟⣉⠀
⣶⢓⣌⣸⢟⣥⡶⣿⣟⠯⠈⠀⢹⡟⡟⢿⣟⣿⣿⣻⣿⣿⣿⣿⣿⣿⣶⣝⠿⣿⣿⣿⣿⣻⣿⣿⣿⣿⣿⠿⠿⣿⣥⠤⣤⣤⣤⣤⣴⣿⣿⠋⠀⠀⠀⢙
⡹⣿⣿⣵⡿⡝⡷⠣⠛⠿⡄⠀⠘⠓⢿⣞⣳⣽⡿⢽⡿⣿⣿⣿⣿⣿⣿⣿⣿⡛⠛⣛⣵⣿⣿⣯⣭⣤⡶⠛⠛⠒⠒⠒⣒⣬⢝⡿⣿⣿⣿⣶⣶⠶⠛⠛
⠿⣿⣿⠈⣽⠋⠓⠤⠀⠀⠈⠐⠲⣤⣼⠿⢧⡘⠀⣷⣿⣿⣿⣿⣿⣿⣿⣿⣷⣻⣿⣿⣿⣿⣛⣛⣛⣽⣿⣿⣯⠶⠚⠉⠁⠀⠀⠉⠻⣿⣿⡗⠘⣧⠀⣀
⠀⢻⣷⣾⣿⣆⠀⠀⠀⠀⢀⡴⠚⠉⠉⣻⣶⣽⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠛⠛⠛⠚⠋⠉⠁⠀⠈⣧⠀⠀⠀⠀⠀⠀⠀⢹⣿⡡⠔⠉⠉⠀
⠀⠀⣿⣿⡻⡿⢿⣦⣄⡠⢥⣲⣶⣾⣿⡿⠛⠛⠿⠿⣉⣛⣋⣽⣾⣿⣿⣿⣿⡿⠃⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠚⠀⠀⠰⣄⡀⠀⣠⡾⠋⠀⠀⠀⠀⠀
⠉⣑⣿⣿⡿⡍⢉⣿⣴⣾⣟⡩⠞⣽⠋⠉⠈⠙⣿⣆⣉⣹⣿⣿⣿⣟⣾⣿⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠤⠯⠛⠁⠀⠀⠀⠀⠀⠀⠀
⣿⣿⣿⣿⣿⣿⡿⣻⢿⢯⡉⠴⠊⠘⠤⠀⠀⣼⣿⣿⡿⣿⣿⡿⡏⢸⠛⣱⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⣿⣻⣿⣿⡟⠁⠹⣯⣷⡆⠀⠀⠰⢦⡀⠀⡀⠿⠛⣿⣿⣿⣿⢿⠀⡸⣿⠏⠀⠀⢀⣀⡠⠤⠄⠒⠒⠒⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⣷⣿⣿⣻⠀⢀⠀⢉⡻⢿⡂⠀⠀⠀⢻⠅⣀⠔⠋⠘⢿⣿⣿⣼⠋⣀⣀⣤⡶⠛⠻⢤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⣿⣿⠘⠯⠲⢞⡷⠋⠀⠀⢱⣴⠶⠒⡺⠯⠀⠀⠀⠀⠘⣿⣿⣿⠿⠏⣉⠉⠻⢦⡀⠀⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⣿⣍⣢⣤⠞⠋⠀⠀⠀⣠⡼⡽⣤⡋⠀⠀⠀⠀⢀⣴⡟⢫⠟⠉⠓⠤⣀⠈⠻⣶⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠛⠋⠁⠀⠀⠀⢀⡴⡾⢅⡙⠷⠭⣾⣆⠀⢀⣴⡿⠋⡰⠁⠀⠀⠀⠀⠀⠉⠉⢪⣻⣿⣷⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
end
