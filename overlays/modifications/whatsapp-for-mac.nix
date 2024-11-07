final: prev: {
  whatsapp-for-mac = prev.whatsapp-for-mac.overrideAttrs (
    finalAttrs: prevAttrs: {
      version = "2.24.16.80";
      src = prev.fetchzip {
        extension = "zip";
        name = "WhatsApp.app";
        url = "https://web.whatsapp.com/desktop/mac_native/release/?version=${finalAttrs.version}&extension=zip&configuration=Release&branch=relbranch";
        hash = "sha256-oPWZCIt0clZl9ZVltBhiheEPXuJQNELLqiRLS91gKvo=";
      };
    }
  );
}
