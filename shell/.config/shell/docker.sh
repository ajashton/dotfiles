# Docker

function docker_latest() {
  docker ps --format "{{.ID}}" | head -n1
}

function dock() {
  local id
  if [ -n "${1:-}" ]; then
    id="$1"
  else
    id="$(docker_latest)"
  fi
  # Connect to a bash session in the latest running docker container
  docker exec -it "$id" bash
}

function dkill() {
  docker kill "$(docker_latest)"
}

function docker_ip() {
  docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$(docker_latest)"
}

# Docker-compatible Podman

if (command -v podman &> /dev/null) && ! (command -v docker &> /dev/null); then
  function docker() {
    command="$1"
    shift
    if [ "$command" = "run" ]; then
      podman run --security-opt label=disable --rm "$@"
    elif [ "$command" = "build" ]; then
      podman build --format=docker "$@"
    else
      podman $command "$@"
    fi
  }
fi
