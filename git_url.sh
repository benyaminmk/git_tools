#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

#/ Usage: ./git_url.sh
#/ Description: Fetch the front-end url to the current git repo
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
# Extract remote origin git repo path from `git remote -v`
RES=$(git remote -v | grep origin | sed -n '1p' | cut -f2 | cut -d" " -f1)

# Transform git's path to the corresponding https browser path
if [[ "${RES}" =~ ^git@.* ]];
then
    info "git repo starts with 'git'"
    HTTPS_RES=$( sed 's/git@/https:\/\//' <<< ${RES} )
    HTTPS_RES=$( sed 's/nak\.co:/nak.co\//' <<< ${HTTPS_RES} )
else
    info "git repo already starts with 'https'"
    HTTPS_RES=${RES}
fi

echo ${HTTPS_RES}
