{ lib', pkgs, ... }@inputs:
lib'.mkCustomModule [ "firefox" ] inputs (
  {
    lib,
    cfg,
    ...
  }:
  {
    options = {
      enable = lib.mkEnableOption "Enables firefox";
    };

    config = lib.mkIf cfg.enable {
      programs.firefox = {
        enable = true;

        package = pkgs.firefox-bin;

        profiles = {
          default = {
            id = 0;

            settings = {
              "browser.warnOnQuit" = false;
              "browser.warnOnQuitShortcut" = false;
              "browser.aboutConfig.showWarning" = false;
              "browser.bookmarks.addedImportButton" = true;
              "browser.bookmarks.restore_default_bookmarks" = false;
              "browser.bookmarks.showMobileBookmarks" = true;
              "browser.startup.homepage" = "https://google.com";
              "browser.firefox-view.feature-tour" = {
                screen = "";
                complete = true;
              };
              "browser.pdfjs.feature-tour" = {
                screen = "";
                complete = true;
              };
              "browser.sessionstore.resume_session_once" = true;
              "font.name.monospace.x-western" = "Monaspace Neon";
              "font.name.sans-serif.x-western" = "Geist";
              "font.name.serif.x-western" = "Geist";
            };

            search = {
              force = true;
              engines = {
                "nixpkgs" = {
                  urls = [
                    {
                      template = "https://search.nixos.org/packages";
                      params = [
                        {
                          name = "channel";
                          value = "unstable";
                        }
                        {
                          name = "from";
                          value = "0";
                        }
                        {
                          name = "size";
                          value = "10";
                        }
                        {
                          name = "type";
                          value = "packages";
                        }
                        {
                          name = "query";
                          value = "{searchTerms}";
                        }
                      ];
                    }
                  ];
                  icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                  definedAliases = [ "@np" ];
                };
                "YouTube" = {
                  urls = [
                    {
                      template = "https://youtube.com/results";
                      params = [
                        {
                          name = "search_query";
                          value = "{searchTerms}";
                        }
                      ];
                    }
                  ];
                  icon = ../../../assets/youtube.svg;
                  definedAliases = [ "@yt" ];
                };
              };
            };
          };

        };
      };
    };
  }
)
