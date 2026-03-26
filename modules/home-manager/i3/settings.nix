{ ... }:

{
  xsession.windowManager.i3.config = {
    # Fonts
    fonts = {
      names = [ "monospace" ];
      size = 8.0;
    };

    # Floating modifier
    floating.modifier = "Mod4";

    # Focus settings
    focus = {
      followMouse = true;
      mouseWarping = true;
    };

    # Window settings
    window = {
      titlebar = false;
      border = 0;
    };
  };
}
