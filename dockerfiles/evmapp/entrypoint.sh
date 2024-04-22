#!/bin/bash
set -eEuo pipefail

# check if this is an unsupported CPU, warn the user and bail
if ! grep -iq adx /proc/cpuinfo || ! grep -iq bmi2 /proc/cpuinfo; then
  echo "Error: the host does not support the required 'adx' and 'bmi2' CPU flags. The application cannot run on older CPUs. Exiting..."
  sleep 5
  exit 1
fi


USER_ID="${LOCAL_USER_ID:-9001}"
GRP_ID="${LOCAL_GRP_ID:-9001}"
LD_PRELOAD="${LD_PRELOAD:-}"

REMOTE_KEY_MANAGER_REQUEST_TIMEOUT=""
REMOTE_KEY_MANAGER_PARALLEL_REQUESTS=""
SCNODE_REST_APIKEYHASH=""
MAX_INCOMING_CONNECTIONS=""
MAX_OUTGOING_CONNECTIONS=""
WS_ADDRESS=""
ONLY_CONNECT_TO_KNOWN_PEERS=""
FORGER_MAXCONNECTIONS=""
FORGER_REWARD_ADDRESS=""
LOG4J_CUSTOM_CONFIG=""

SCNODE_REMOTE_KEY_MANAGER_ENABLED="${SCNODE_REMOTE_KEY_MANAGER_ENABLED:-false}"
export SCNODE_REMOTE_KEY_MANAGER_ENABLED

SCNODE_METRICS_ENABLED="${SCNODE_METRICS_ENABLED:-false}"
SCNODE_METRICS_PORT="${SCNODE_METRICS_PORT:-9088}"
export SCNODE_METRICS_ENABLED SCNODE_METRICS_PORT
SCNODE_METRICS_APIKEYHASH=""


# Function(s)
fn_die() {
  echo -e "$1" >&2
  sleep 5
  exit "${2:-1}"
}

detect_ext_ip() {
  local usage="Detect external IPv(4|6) address - usage: ${FUNCNAME[0]} {(4|6)}}"
  [ "${1:-}" = "usage" ] && echo "${usage}" && return
  [ "$#" -ne 1 ] && { fn_die "${FUNCNAME[0]} error: function requires exactly one argument.\n\n${usage}"; }

  local ip_type="${1}"
  if ! [[ "${ip_type}" =~ ^(4|6)$ ]]; then
    fn_die "${FUNCNAME[0]} error: function expects either '4' or '6' as an argument.\n\n${usage}"
  fi

  ip_address="$(dig -"${ip_type}" +short +time=2 @resolver1.opendns.com ANY myip.opendns.com 2> /dev/null | grep -v ";" || true)"
  if ! { ipv6calc -qim "${ip_address:-}" | grep 'TYPE' | grep -q 'global'; } 2>/dev/null; then
    ip_address="$(curl -s -"${ip_type}" icanhazip.com 2>/dev/null || true)"
  fi

  echo "${ip_address}"
}



if [ "$USER_ID" != "0" ]; then
    getent group "$GRP_ID" &> /dev/null || groupadd -g "$GRP_ID" user
    id -u user &> /dev/null || useradd --shell /bin/bash -u "$USER_ID" -g "$GRP_ID" -o -c "" -m user
    CURRENT_UID="$(id -u user)"
    CURRENT_GID="$(id -g user)"
    if [ "$USER_ID" != "$CURRENT_UID" ] || [ "$GRP_ID" != "$CURRENT_GID" ]; then
        echo -e "WARNING: User with differing UID $CURRENT_UID/GID $CURRENT_GID already exists, most likely this container was started before with a different UID/GID. Re-create it to change UID/GID.\n"
    fi
else
    CURRENT_UID="$USER_ID"
    CURRENT_GID="$GRP_ID"
    echo -e "WARNING: Starting container processes as root. This has some security implications and goes against docker best practice.\n"
fi

# set $HOME
if [ "$CURRENT_UID" != "0" ]; then
    export USERNAME=user
    export HOME=/home/"$USERNAME"
else
    export USERNAME=root
    export HOME=/root
fi

# Checking if external IP address is provided by the user via ENV var
if [ -n "${SCNODE_NET_DECLAREDADDRESS:-}" ]; then
  # Checking user provided public IPv(4|6) address validity
  if ! { ipv6calc -qim "${SCNODE_NET_DECLAREDADDRESS}" | grep 'TYPE' | grep -q 'global'; } 2>/dev/null; then
    fn_die "Error: provided via environment variable IP address = ${SCNODE_NET_DECLAREDADDRESS} does not match a valid IPv4 or IPv6 format or is NOT a PUBLIC address.\nFix it before proceeding any further.  Exiting ..."
  fi
else
  # Detecting IPv4 vs IPv6 address
  SCNODE_NET_DECLAREDADDRESS="$(detect_ext_ip 4)"
  if ! { ipv6calc -qim "${SCNODE_NET_DECLAREDADDRESS:-}" | grep 'TYPE' | grep -q 'global'; } 2>/dev/null; then
    SCNODE_NET_DECLAREDADDRESS="$(detect_ext_ip 6)"
  fi

  # Falling over to internal IP
  if ! { ipv6calc -qim "${SCNODE_NET_DECLAREDADDRESS:-}" | grep 'TYPE' | grep -q 'global'; } 2>/dev/null; then
    echo "Error: Failed to detect external IPv(4|6) address, using internal address."
    SCNODE_NET_DECLAREDADDRESS="$(hostname -I | cut -d ' ' -f1 || true)"
    if [ -n "${SCNODE_NET_DECLAREDADDRESS}" ]; then
      SCNODE_NET_DECLAREDADDRESS="${SCNODE_NET_DECLAREDADDRESS%% }"
    else
      SCNODE_NET_DECLAREDADDRESS="127.0.0.1"
    fi
  fi
fi
export SCNODE_NET_DECLAREDADDRESS

#Custom log4j file (optional)
if [ -n "${SCNODE_LOG4J_CUSTOM_CONFIG:-}" ]; then
  if ! [ -f "${SCNODE_LOG4J_CUSTOM_CONFIG}" ]; then
    echo "Error: Custom log4j file was not found under the provided path = ${SCNODE_LOG4J_CUSTOM_CONFIG}. Please check the value of the environment variable 'SCNODE_LOG4J_CUSTOM_CONFIG' and make sure your custom log4j file is correctly mapped to the container."
    sleep 5
    exit 1
  fi
  LOG4J_CUSTOM_CONFIG="-Dlog4j.configurationFile=${SCNODE_LOG4J_CUSTOM_CONFIG}"
fi

to_check=(
  "SCNODE_CERT_SIGNERS_MAXPKS"
  "SCNODE_CERT_SIGNERS_PUBKEYS"
  "SCNODE_CERT_SIGNERS_THRESHOLD"
  "SCNODE_CERT_SIGNING_ENABLED"
  "SCNODE_CERT_MASTERS_PUBKEYS"
  "SCNODE_CERT_SUBMITTER_ENABLED"
  "SCNODE_FORGER_ENABLED"
  "SCNODE_FORGER_RESTRICT"
  "SCNODE_GENESIS_BLOCKHEX"
  "SCNODE_GENESIS_SCID"
  "SCNODE_GENESIS_POWDATA"
  "SCNODE_GENESIS_MCBLOCKHEIGHT"
  "SCNODE_GENESIS_MCNETWORK"
  "SCNODE_GENESIS_WITHDRAWALEPOCHLENGTH"
  "SCNODE_GENESIS_COMMTREEHASH"
  "SCNODE_GENESIS_ISNONCEASING"
  "SCNODE_NET_DECLAREDADDRESS"
  "SCNODE_NET_KNOWNPEERS"
  "SCNODE_NET_MAGICBYTES"
  "SCNODE_NET_NODENAME"
  "SCNODE_NET_P2P_PORT"
  "SCNODE_NET_API_LIMITER_ENABLED"
  "SCNODE_NET_SLOW_MODE"
  "SCNODE_NET_REBROADCAST_TXS"
  "SCNODE_NET_HANDLING_TXS"
  "SCNODE_REST_PORT"
  "SCNODE_WALLET_SEED"
  "SCNODE_WALLET_MAXTX_FEE"
  "SCNODE_WS_SERVER_PORT"
  "SCNODE_WS_CLIENT_ENABLED"
  "SCNODE_WS_SERVER_ENABLED"
)
for var in "${to_check[@]}"; do
  if [ -z "${!var:-}" ]; then
    echo "Error: Mandatory environment variable ${var} is required."
    sleep 5
    exit 1
  fi
done

if [ "${SCNODE_FORGER_RESTRICT:-}" = "true" ]; then
  if [ -z "${SCNODE_ALLOWED_FORGERS:-}" ]; then
    echo "Error: Environment variable SCNODE_ALLOWED_FORGERS is required when SCNODE_FORGER_RESTRICT=true."
    sleep 5
    exit 1
  fi
fi

# Cert signing
if [ "${SCNODE_CERT_SIGNING_ENABLED:-}" = "true" ]; then
  # Checking first for either SCNODE_CERT_SIGNERS_SECRETS not empty and SCNODE_REMOTE_KEY_MANAGER_ENABLED !=true and vice versa
  if [ -z "${SCNODE_CERT_SIGNERS_SECRETS:-}" ] && [ "${SCNODE_REMOTE_KEY_MANAGER_ENABLED:-}" != "true" ]; then
    echo "Error: if SCNODE_CERT_SIGNING_ENABLED=true either SCNODE_CERT_SIGNERS_SECRETS must NOT be empty or SCNODE_REMOTE_KEY_MANAGER_ENABLED=true is required to be set."
    sleep 5
    exit 1
  fi

  # Checking all REMOTE_KEY_MANAGER_ENABLED parameters when SCNODE_REMOTE_KEY_MANAGER_ENABLED=true
  if [ "${SCNODE_REMOTE_KEY_MANAGER_ENABLED:-}" = "true" ]; then
    # Checking KEY_MANAGER_REQUEST_TIMEOUT
    if [ -z "${SCNODE_REMOTE_KEY_MANAGER_REQUEST_TIMEOUT:-}" ]; then
      echo "Error: When SCNODE_CERT_SIGNING_ENABLED=true and SCNODE_REMOTE_KEY_MANAGER_ENABLED=true, 'SCNODE_REMOTE_KEY_MANAGER_REQUEST_TIMEOUT' variable is required to be set."
      sleep 5
      exit 1
    else
      REMOTE_KEY_MANAGER_REQUEST_TIMEOUT="$(echo -en "\n        requestTimeout = ${SCNODE_REMOTE_KEY_MANAGER_REQUEST_TIMEOUT}")"
      export REMOTE_KEY_MANAGER_REQUEST_TIMEOUT
    fi

    # Checking KEY_MANAGER_PARALLEL_REQUESTS
    if [ -z "${SCNODE_REMOTE_KEY_MANAGER_PARALLEL_REQUESTS:-}" ]; then
      echo "Error: When SCNODE_CERT_SIGNING_ENABLED=true and SCNODE_REMOTE_KEY_MANAGER_ENABLED=true, 'SCNODE_REMOTE_KEY_MANAGER_PARALLEL_REQUESTS' variable is required to be set."
      sleep 5
      exit 1
    else
      REMOTE_KEY_MANAGER_PARALLEL_REQUESTS="$(echo -en "\n        numOfParallelRequests = ${SCNODE_REMOTE_KEY_MANAGER_PARALLEL_REQUESTS}")"
      export REMOTE_KEY_MANAGER_PARALLEL_REQUESTS
    fi

    # Checking REMOTE_KEY_MANAGER_ADDRESS and its connectivity
    if [ -z "${SCNODE_REMOTE_KEY_MANAGER_ADDRESS:-}" ]; then
      echo "Error: When SCNODE_CERT_SIGNING_ENABLED=true and SCNODE_REMOTE_KEY_MANAGER_ENABLED=true SCNODE_REMOTE_KEY_MANAGER_ADDRESS needs to be set."
      sleep 5
      exit 1
    else
      host="$(cut -d'/' -f 3 <<< "${SCNODE_REMOTE_KEY_MANAGER_ADDRESS}" | cut -d':' -f 1)"
      port="$(cut -d ':' -f 3 <<< "${SCNODE_REMOTE_KEY_MANAGER_ADDRESS}")"
      port="${port:-80}"
      # make sure host and port are reachable
      i=0
      while ! nc -z "${host}" "${port}" &> /dev/null; do
       echo "Waiting for '${SCNODE_REMOTE_KEY_MANAGER_ADDRESS}' endpoint to be ready."
       sleep 5
       i="$((i+1))"
       if [ "$i" -gt 48 ]; then
         echo "Error: '${SCNODE_REMOTE_KEY_MANAGER_ADDRESS}' endpoint is not ready after 4 minutes."
         exit 1
       fi
      done
    fi
  fi
fi

if [ "${SCNODE_FORGER_ENABLED:-}" = "true" ] || [ "${SCNODE_CERT_SUBMITTER_ENABLED:-}" = "true" ]; then
  if [ -z "${SCNODE_WS_ZEN_FQDN:-}" ]; then
    echo "Error: Environment variable SCNODE_WS_ZEN_FQDN is required when SCNODE_FORGER_ENABLED=true or SCNODE_CERT_SUBMITTER_ENABLED=true."
    sleep 5
    exit 1
  fi
fi

if [ -n "${SCNODE_FORGER_REWARD_ADDRESS:-}" ]; then
  if [ "${SCNODE_FORGER_ENABLED:-}" = "true" ]; then
    FORGER_REWARD_ADDRESS="$(echo -en "\n        forgerRewardAddress = \"${SCNODE_FORGER_REWARD_ADDRESS}\"")"
  else
    echo "Warn: Environment variable SCNODE_FORGER_REWARD_ADDRESS is set but will be ignored since forging is not enabled"
  fi
fi
export FORGER_REWARD_ADDRESS

FORGER_MAXCONNECTIONS="$(echo -en "\n        maxForgerConnections = ${SCNODE_FORGER_MAXCONNECTIONS:-100}")"
export FORGER_MAXCONNECTIONS

# setting onlyConnectToKnownPeers if provided
if [ -n "${SCNODE_ONLY_CONNECT_TO_KNOWN_PEERS:-}" ]; then
  ONLY_CONNECT_TO_KNOWN_PEERS="$(echo -en "\n        onlyConnectToKnownPeers = ${SCNODE_ONLY_CONNECT_TO_KNOWN_PEERS}")"
fi
export ONLY_CONNECT_TO_KNOWN_PEERS

# Flexibility for log levels and log file name
if [ -z "${SCNODE_LOG_FILE_LEVEL:-}" ]; then
  SCNODE_LOG_FILE_LEVEL='info'
fi

if [ -z "${SCNODE_LOG_CONSOLE_LEVEL:-}" ]; then
  SCNODE_LOG_CONSOLE_LEVEL='info'
fi

if [ -z "${SCNODE_LOG_FILE_NAME:-}" ]; then
  SCNODE_LOG_FILE_NAME='debug.log'
fi
export SCNODE_LOG_FILE_LEVEL SCNODE_LOG_CONSOLE_LEVEL SCNODE_LOG_FILE_NAME

# set REST API password hash
if [ -n "${SCNODE_REST_PASSWORD:-}" ]; then
  SCNODE_REST_APIKEYHASH="$(echo -en "\n        apiKeyHash = \"$(htpasswd -nbBC 10 "" "${SCNODE_REST_PASSWORD}" | tr -d ':\n')\"")"
fi
export SCNODE_REST_APIKEYHASH

# set Metrics API password hash
if [ "${SCNODE_METRICS_ENABLED}" = "true" ]; then
  if [ -n "${SCNODE_METRICS_REST_PASSWORD:-}" ]; then
    SCNODE_METRICS_APIKEYHASH="$(echo -en "\n        apiKeyHash = \"$(htpasswd -nbBC 10 "" "${SCNODE_METRICS_REST_PASSWORD}" | tr -d ':\n')\"")"
  fi
fi
export SCNODE_METRICS_APIKEYHASH

# setting maxIncomingConnections if provided
if [ -n "${SCNODE_NET_MAX_IN_CONNECTIONS:-}" ]; then
  MAX_INCOMING_CONNECTIONS="$(echo -en "\n        maxIncomingConnections = ${SCNODE_NET_MAX_IN_CONNECTIONS}")"
fi
export MAX_INCOMING_CONNECTIONS

# setting maxOutgoingConnections if provided
if [ -n "${SCNODE_NET_MAX_OUT_CONNECTIONS:-}" ]; then
  MAX_OUTGOING_CONNECTIONS="$(echo -en "\n        maxOutgoingConnections = ${SCNODE_NET_MAX_OUT_CONNECTIONS}")"
fi
export MAX_OUTGOING_CONNECTIONS

# download and extract backup for import
backupdir="/sidechain/datadir/backupStorage"
if [ -n "${SCNODE_BACKUP_TAR_GZ_URL:-}" ] && ! [ -f "${backupdir}/.import_done" ]; then
  echo "Importing backup from '${SCNODE_BACKUP_TAR_GZ_URL}' to '${backupdir}'."
  mkdir -p "${backupdir}"
  curl -L "${SCNODE_BACKUP_TAR_GZ_URL}" | tar -xzf - -C "${backupdir}"
  touch "${backupdir}/.import_done"
fi

# detect zend container IP, check zend is up and websocket port is reachable
if [ -n "${SCNODE_WS_ZEN_FQDN:-}" ]; then
  to_check=(
    "RPC_PASSWORD"
    "RPC_PORT"
    "RPC_USER"
    "SCNODE_WS_ZEN_PORT"
  )
  for var in "${to_check[@]}"; do
    if [ -z "${!var:-}" ]; then
      echo "Error: Environment variable ${var} required when SCNODE_WS_ZEN_FQDN is set."
      sleep 5
      exit 1
    fi
  done

  # detect IP address
  i=0
  while true; do
    SCNODE_WS_ZEN_IP="$(dig A +short "${SCNODE_WS_ZEN_FQDN}" | grep -v ";" || true)"
    if [ -n "${SCNODE_WS_ZEN_IP:-}" ]; then
      break
    fi
    sleep 5
    i="$((i+1))"
    if [ "$i" -gt 48 ]; then
      echo "Error: Failed to detect IP address of '${SCNODE_WS_ZEN_FQDN}' container after 4 minutes."
      exit 1
    fi
  done
  export SCNODE_WS_ZEN_IP
  echo "Detected IP address '${SCNODE_WS_ZEN_IP}' of '${SCNODE_WS_ZEN_FQDN}' container."

  # make sure zend is up by checking RPC interface
  i=0
  while [ -n "$( (curl -s --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getblockcount", "params": [] }' -H 'content-type: text/plain;' -u "${RPC_USER}:${RPC_PASSWORD}" "http://${SCNODE_WS_ZEN_IP}:${RPC_PORT}/" || echo '{"error":"connection error"}') | jq 'select(has("code") or has("error") and ."error" != null)')" ]; do
    echo "Waiting for '${SCNODE_WS_ZEN_FQDN}' container to be ready."
    sleep 5
    i="$((i+1))"
    if [ "$i" -gt 48 ]; then
      echo "Error: '${SCNODE_WS_ZEN_FQDN}' container not ready after 4 minutes."
      exit 1
    fi
  done
  echo "RPC server of '${SCNODE_WS_ZEN_FQDN}' container ready."

  # make sure websocket port is reachable
  i=0
  while ! nc -z "${SCNODE_WS_ZEN_IP}" "${SCNODE_WS_ZEN_PORT}" &> /dev/null; do
    echo "Waiting for '${SCNODE_WS_ZEN_FQDN}' container websocket port to be ready."
    sleep 5
    i="$((i+1))"
    if [ "$i" -gt 48 ]; then
      echo "Error: '${SCNODE_WS_ZEN_FQDN}' container websocket port not ready after 4 minutes."
      exit 1
    fi
  done
  echo "Websocket server of '${SCNODE_WS_ZEN_FQDN}' container ready."

  # Setting websocket address option under conf file
  WS_ADDRESS="ws://${SCNODE_WS_ZEN_IP}:${SCNODE_WS_ZEN_PORT}"
fi
export WS_ADDRESS

# convert literal '\n' to newlines
SCNODE_CERT_SIGNERS_PUBKEYS="$(echo -e "${SCNODE_CERT_SIGNERS_PUBKEYS:-}")"
SCNODE_CERT_SIGNERS_SECRETS="$(echo -e "${SCNODE_CERT_SIGNERS_SECRETS:-}")"
SCNODE_CERT_MASTERS_PUBKEYS="$(echo -e "${SCNODE_CERT_MASTERS_PUBKEYS:-}")"
SCNODE_ALLOWED_FORGERS="$(echo -e "${SCNODE_ALLOWED_FORGERS:-}")"
SCNODE_NET_KNOWNPEERS="$(echo -e "${SCNODE_NET_KNOWNPEERS:-}")"
export SCNODE_CERT_SIGNERS_PUBKEYS
export SCNODE_CERT_SIGNERS_SECRETS
export SCNODE_CERT_MASTERS_PUBKEYS
export SCNODE_ALLOWED_FORGERS
export SCNODE_NET_KNOWNPEERS

# substitute env vars in scnode config file
# shellcheck disable=SC2016,SC2026
SUBST='$SCNODE_CERT_MASTERS_PUBKEYS:$SCNODE_CERT_SIGNERS_MAXPKS:$SCNODE_CERT_SIGNERS_PUBKEYS:$SCNODE_CERT_SIGNERS_SECRETS:$SCNODE_CERT_SIGNERS_THRESHOLD:$SCNODE_CERT_SIGNING_ENABLED:'\
'$SCNODE_CERT_SUBMITTER_ENABLED:$SCNODE_GENESIS_BLOCKHEX:$SCNODE_GENESIS_SCID:$SCNODE_GENESIS_POWDATA:$SCNODE_GENESIS_MCBLOCKHEIGHT:$SCNODE_GENESIS_MCNETWORK:'\
'$SCNODE_GENESIS_WITHDRAWALEPOCHLENGTH:$SCNODE_GENESIS_COMMTREEHASH:$SCNODE_GENESIS_ISNONCEASING:$SCNODE_ALLOWED_FORGERS:$SCNODE_FORGER_ENABLED:$SCNODE_FORGER_RESTRICT:'\
'$SCNODE_NET_DECLAREDADDRESS:$SCNODE_NET_KNOWNPEERS:$SCNODE_NET_MAGICBYTES:$SCNODE_NET_NODENAME:$SCNODE_NET_P2P_PORT:$SCNODE_NET_API_LIMITER_ENABLED:$SCNODE_NET_SLOW_MODE:$SCNODE_NET_REBROADCAST_TXS:$SCNODE_NET_HANDLING_TXS:'\
'$SCNODE_WALLET_GENESIS_SECRETS:$SCNODE_WALLET_MAXTX_FEE:$SCNODE_WALLET_SEED:$WS_ADDRESS:$MAX_INCOMING_CONNECTIONS:$MAX_OUTGOING_CONNECTIONS:$SCNODE_WS_SERVER_PORT:'\
'$SCNODE_WS_CLIENT_ENABLED:$SCNODE_WS_SERVER_ENABLED:$SCNODE_REMOTE_KEY_MANAGER_ENABLED:$SCNODE_REMOTE_KEY_MANAGER_ADDRESS:$SCNODE_LOG_FILE_LEVEL:$SCNODE_LOG_CONSOLE_LEVEL:$SCNODE_LOG_FILE_NAME:$REMOTE_KEY_MANAGER_REQUEST_TIMEOUT:$REMOTE_KEY_MANAGER_PARALLEL_REQUESTS:'\
'$SCNODE_REST_APIKEYHASH:$SCNODE_REST_PORT:$ONLY_CONNECT_TO_KNOWN_PEERS:$FORGER_MAXCONNECTIONS:$FORGER_REWARD_ADDRESS:$SCNODE_METRICS_ENABLED:$SCNODE_METRICS_PORT:$SCNODE_METRICS_APIKEYHASH'\

export SUBST
envsubst "${SUBST}" < /sidechain/config/sc_settings.conf.tmpl > /sidechain/config/sc_settings.conf
unset SUBST

# set file ownership
find /sidechain -writable -print0 | xargs -0 -I{} -P64 -n1 chown -f "${CURRENT_UID}":"${CURRENT_GID}" "{}"

# preload libjemalloc2
path_to_jemalloc="$(ldconfig -p | grep "$(arch)" | grep 'libjemalloc\.so\.2$' | tr -d ' ' | cut -d '>' -f 2)"
export LD_PRELOAD="${path_to_jemalloc}:${LD_PRELOAD}"

if [ "${1}" = "/usr/bin/true" ]; then
  if [ -z "${LOG4J_CUSTOM_CONFIG:-}" ]; then
     set -- java -cp '/sidechain/'"${SC_JAR_NAME}"'-'"${SC_VERSION}"'.jar:/sidechain/lib/*' "$SC_MAIN_CLASS" "$SC_CONF_PATH"
  else
     set -- java -cp '/sidechain/'"${SC_JAR_NAME}"'-'"${SC_VERSION}"'.jar:/sidechain/lib/*' "${LOG4J_CUSTOM_CONFIG}" "$SC_MAIN_CLASS" "$SC_CONF_PATH"
  fi
fi

echo "Username: ${USERNAME}, UID: ${CURRENT_UID}, GID: ${CURRENT_GID}"
echo "LD_PRELOAD: ${LD_PRELOAD}"
echo "Starting sidechain node."
echo "Command: '$*'"

if [ "${USERNAME}" = "user" ]; then
    exec /usr/local/bin/gosu user "$@"
else
    exec "$@"
fi
