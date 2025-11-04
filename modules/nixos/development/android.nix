{ ... }:

{
  nixpkgs.config.android_sdk.accept_license = true;
  system.userActivationScripts = {
    stdio = {
      text = ''
        rm -f ~/Android/Sdk/platform-tools/adb
        ln -s /run/current-system/sw/bin/adb ~/Android/Sdk/platform-tools/adb
      '';
      # deps = [ ];
    };
  };
}
