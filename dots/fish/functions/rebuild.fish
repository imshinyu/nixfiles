# ~/.config/fish/functions/rebuild.fish
function rebuild
    set -l host (hostname)
    
    echo "🔄 Rebuilding NixOS for $host..."
    
    if sudo nixos-rebuild switch --flake ~/nixfiles/#$host
        echo "✅ Rebuild successful"
        echo "✨ Running hjem-impure..."
        if hjem-impure
            echo "🎉 All done!"
        else
            echo "⚠️ hjem-impure failed (but rebuild succeeded)"
            return 1
        end
    else
        echo "❌ Rebuild failed"
        return 1
    end
end
