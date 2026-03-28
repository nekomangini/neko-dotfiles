{ ... }:

{
  xsession.windowManager.i3.config = {
    assigns = {
      "9" = [
        { class = "^Vivaldi-stable$"; }
        { class = "^ticktick$"; }
        { class = "^Godot$"; }
        { class = "^dolphin$"; }
        { class = "^gwenview$"; }
        { class = "^Blender$"; }
        { class = "^krita$"; }
      ];

      "10" = [
        { class = "^kitty$"; }
        { class = "^dev.zed.Zed$"; }
        { class = "^jetbrains-studio$"; }
        { class = "^obsidian$"; }
        { class = "^Logseq$"; }
        { class = "^Joplin$"; }
        { class = "^Emacs$"; }
      ];
    };

    workspaceOutputAssign = [
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
