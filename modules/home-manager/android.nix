{ pkgs, ... }:

{
  home.packages = with pkgs; [
    android-studio
    android-tools
    gradle
    jdk17

    flutter
    ninja
    pkg-config
    mesa-demos
  ];

  home.sessionVariables = {
    CHROME_EXECUTABLE = "${pkgs.vivaldi}/bin/vivaldi";
    ANDROID_HOME = "$HOME/Android/Sdk";
    ANDROID_SDK_ROOT = "$HOME/Android/Sdk";
    JAVA_HOME = "${pkgs.jdk17.home}";
  };
}
