############################################
#   Docker Power Aliases & Functions
############################################

alias d='docker'
alias dc='docker container'
alias di='docker image'
alias dn='docker network'
alias dv='docker volume'
alias dco='docker compose'

# --- Quick List Shortcuts ---
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dimg='docker images'
alias dnet='docker network ls'
alias dvol='docker volume ls'

# --- Inspect shortcuts ---
alias dins='docker inspect'
alias dlogs='docker logs'
alias dlogsf='docker logs -f'

# --- Stop / Kill / Remove ---
alias dst='docker stop'
alias dkill='docker kill'
alias drm='docker rm'
alias drmi='docker rmi'
alias dprune='docker system prune -f'

# Stop and remove all containers
dclean() {
  echo "🧹 Stopping & removing all containers..."
  docker stop $(docker ps -aq) 2>/dev/null || true
  docker rm $(docker ps -aq) 2>/dev/null || true
}

# Remove dangling images
dcleanimg() {
  echo "🧼 Removing dangling images..."
  docker image prune -f
}

# Remove all unused volumes
dcleanvol() {
  echo "🧽 Removing unused volumes..."
  docker volume prune -f
}

# --- Exec into running container ---
dex() {
  CONTAINER="$1"
  if [[ -z "$CONTAINER" ]]; then
    echo "Usage: dex <container>"
    return 1
  fi
  docker exec -it "$CONTAINER" bash 2>/dev/null || \
  docker exec -it "$CONTAINER" sh
}

# --- Logs for newest container matching name ---
dlast() {
  NAME="$1"
  if [[ -z "$NAME" ]]; then
    echo "Usage: dlast <partial_container_name>"
    return 1
  fi

  CID=$(docker ps --format "{{.ID}} {{.Names}} {{.CreatedAt}}" \
        | grep "$NAME" | head -1 | awk '{print $1}')

  if [[ -z "$CID" ]]; then
    echo "No running container matches: $NAME"
    return 1
  fi

  echo "📄 Logs for $CID"
  docker logs -f "$CID"
}

# --- Start a shell in the latest container ---
dshell() {
  CID=$(docker ps -q | head -1)
  [[ -z "$CID" ]] && echo "❌ No running containers." && return 1
  echo "🔌 Connecting to container $CID"
  docker exec -it "$CID" bash 2>/dev/null || docker exec -it "$CID" sh
}

# --- Build ---
alias dbuild='docker build .'
dbi() { docker build -t "$1" .; }

# --- Run ---
drun() { docker run -it "$1" bash; }

# --- Stop all ---
dstopall() {
  echo "🛑 Stopping all containers..."
  docker stop $(docker ps -q)
}

# --- Remove all containers ---
drmall() {
  echo "🧽 Removing all containers..."
  docker rm -f $(docker ps -aq)
}

# --- Full nuke: images, containers, volumes ---
dnuke() {
  echo "💣 Removing ALL containers, images, volumes…"
  docker rm -f $(docker ps -aq) 2>/dev/null || true
  docker rmi -f $(docker images -q) 2>/dev/null || true
  docker volume rm $(docker volume ls -q) 2>/dev/null || true
  docker network prune -f
  echo "🔥 Docker fully reset."
}

