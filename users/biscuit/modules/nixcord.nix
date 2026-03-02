{config, pkgs, inputs, ...}:
{
  programs.nixcord = {
    enable = true;
    user = "biscuit";
    discord = {
      # equicord.enable = true; 
      vencord.enable = true;
    };
    # vesktop.enable = true;
    config = {
      frameless = true;
      plugins = {
        BlurNSFW.enable = true;
        expressionCloner.enable = true;
        fakeNitro.enable = true;
        fixSpotifyEmbeds.enable = true;
        fixYoutubeEmbeds.enable = true;
        gameActivityToggle.enable = true;
        mentionAvatars.enable = true;
        previewMessage.enable = true;
        readAllNotificationsButton.enable = true;
        spotifyControls.enable = true;
        spotifyCrack.enable = true;
        translate.enable = true;
        typingIndicator.enable = true;
        typingTweaks.enable = true;
        viewIcons.enable = true;
        voiceDownload.enable = true;
        voiceMessages.enable = true;
        volumeBooster.enable = true;
        whoReacted.enable = true;
        youtubeAdblock.enable = true;
    #     UserPFP.enable = true;
    #     RPCEditor.enable = true;
    #     VCPanelSettings.enable = true;
    #     altKrispSwitch.enable = true;
      };
    };
  };
}
