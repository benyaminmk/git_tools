#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

#/ Usage: check-repos.sh
#/ Description: Check vcsh and all mr repositories
#/ Examples:
#/ Options:
#/   --help: Display this help message
usage() { grep '^#/' "$0" | cut -c4- ; exit 0 ; }
expr "$*" : ".*--help" > /dev/null && usage

readonly LOG_FILE="/tmp/$(basename "$0").log"
info()    { echo "[INFO]    $*" | tee -a "$LOG_FILE" >&2 ; }
warning() { echo "[WARNING] $*" | tee -a "$LOG_FILE" >&2 ; }
error()   { echo "[ERROR]   $*" | tee -a "$LOG_FILE" >&2 ; }
fatal()   { echo "[FATAL]   $*" | tee -a "$LOG_FILE" >&2 ; exit 1 ; }


# Main ----
readonly old_wd=${PWD}

cd ~
vcsh dot-files fetch
vcsh dot-files status
vcsh dot-files pull
vcsh dot-files push
cd /
mr s
mr up

