{ pkgs, ... }:

{
  home.packages = with pkgs; [
    android-studio
    android-tools
    android-udev-rules
    gradle
    jdk17

    flutter
    ninja
    pkg-config
    mesa-demos
  ];

  home.sessionVariables = {
    CHROME_EXECUTABLE = "${pkgs.vivaldi}/bin/vivaldi";
    # TODO:
    # ANDROID_HOME = "$HOME/Android/Sdk";
    # JAVA_HOME = "${pkgs.jdk17}/lib/openjdk";
    # JAVA_HOME = "${pkgs.jdk17}/share/android-studio/jbr";
    ANDROID_SDK_ROOT = "${pkgs.android-studio}/android-sdk";
    JAVA_HOME = "${pkgs.jdk17}/lib/openjdk";
  };
}
