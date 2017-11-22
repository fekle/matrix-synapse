#!/bin/bash
set -euf

cd "${SYNAPSE_DATA_DIR}"

case "${1:-}" in
start)
  printf 'starting matrix-synapse at %s\n' "$(date)"
  rm -rf homeserver.pid &>/dev/null || true
  env LD_PRELOAD="${SYNAPSE_ETC}/stackfix/stack.so" python2 -m synapse.app.homeserver -c "${SYNAPSE_CONFIG_FILE}" --report-stats no
  ;;
bash)
  printf 'starting bash at %s\n' "$(date)"
  exec bash ${@:2}
  ;;
*)
  printf 'usage: %s <start|bash> \n' "${0}"
  ;;
esac
