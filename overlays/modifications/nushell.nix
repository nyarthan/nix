final: prev: {
  nushell = prev.nushell.overrideAttrs (
    finalAttrs: prevAttrs: {
      checkPhase = ''
        runHook preCheck
        (
        # The skipped tests all fail in the sandbox because in the nushell test playground,
        # the tmp $HOME is not set, so nu falls back to looking up the passwd dir of the build
        # user (/var/empty). The assertions however do respect the set $HOME.
        set -x
        HOME=$(mktemp -d) cargo test -j $NIX_BUILD_CORES --offline -- \
        --test-threads=$NIX_BUILD_CORES \
        --skip=repl::test_config_path::test_default_config_path \
        --skip=repl::test_config_path::test_xdg_config_bad \
        --skip=repl::test_config_path::test_xdg_config_empty \
        --skip=repl::test_parser::filesize_with_underscores_2 \
        --skip=repl::test_parser::filesize_with_underscores_1
        )
        runHook postCheck
      '';
    }
  );
}
