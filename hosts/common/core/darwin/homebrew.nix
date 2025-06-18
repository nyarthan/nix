{ ... }:
{
  homebrew = {
    enable = false;
    onActivation.cleanup = "zap";
    caskArgs.no_quarantine = true;
    global = {
      brewfile = true;
    };

    casks = [
      "raycast"
      "steam"
    ];
  };

}
