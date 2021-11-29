DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${DIR}"/styles.env

clone_repository() {
  REPO=$1
  REPO_DIR=$2

  if [[ -d ${REPO_DIR} && ! "$(ls -A "$REPO_DIR")" ]]; then
    sudo rm -rf "$REPO_DIR"
  fi

  if [[ -d ${REPO_DIR} ]]; then
    cd "${REPO_DIR}" || return
    git pull
    cd "${DIR}"/.. || return
  else
    git clone "${REPO}" "${REPO_DIR}"
  fi
}