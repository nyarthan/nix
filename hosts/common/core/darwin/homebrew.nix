{ ... }:
{
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    caskArgs.no_quarantine = true;
    global = {
      brewfile = true;
    };

    casks = [
      "raycast"
    ];
  };

}
