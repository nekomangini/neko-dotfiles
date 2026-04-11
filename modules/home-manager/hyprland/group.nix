{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    group = {
      "col.border_active" = "rgba(43f2d6ff)";
      "col.border_inactive" = "rgba(5fc49726)";
      "col.border_locked_active" = "rgba(f29718ff)";
      "col.border_locked_inactive" = "rgba(40524fff)";

      groupbar = {
        enabled = true;
        font_family = "FiraCode Nerd Font";
        font_size = 12;
        height = 20;
        "col.active" = "rgba(43f2d6ff)";
        "col.inactive" = "rgba(121f1dff)";
      };
    };
  };
}
