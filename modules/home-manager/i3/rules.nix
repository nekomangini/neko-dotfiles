{ ... }:

{
  xsession.windowManager.i3.config = {
    assigns = {
      "8" = [
        { class = "^brave-browser$"; }
        { class = "^gwenview$"; }
        { class = "^Zathura$"; }
        { class = "^Godot$"; }
        { class = "^Blender$"; }
      ];
      "9" = [
        { class = "^Vivaldi-stable$"; }
        { class = "^ticktick$"; }
        { class = "^dolphin$"; }
        { class = "^krita$"; }
        { class = "^obsidian$"; }
        { class = "^Logseq$"; }
        { class = "^Joplin$"; }
      ];

      "10" = [
        { class = "^kitty$"; }
        { class = "^dev.zed.Zed$"; }
        { class = "^jetbrains-studio$"; }
        { class = "^Emacs$"; }
        { class = "^okular$"; }
      ];
    };

    workspaceOutputAssign = [
      {
        workspace = "8";
        output = "DP-1";
      }
      {
        workspace = "9";
        output = "DVI-D-0";
      }
      {
        workspace = "10";
        output = "HDMI-0";
      }
    ];
  };
}
