FROM ubuntu:noble
ARG KCLIENT_RELEASE

RUN \ 
printf "%s\n" "Install Build Deps" \
  "██████████████████████████████████████████████████" \
  "▒▒                                              ▒▒" \
  "▒▒             Install Build Deps               ▒▒" \
  "▒▒                                              ▒▒" \
  "██████████████████████████████████████████████████" && \ 
apt update && \ 
DEBIAN_FRONTEND="noninteractive" apt install -y \
  "wget" \
  "curl" \
  "g++" \
  "gcc" \
  "libpam0g-dev" \
  "libpulse-dev" \
  "make" \
  "nodejs" \
  "npm"

RUN \ 
printf "%s\n" "Grab Source" \
  "██████████████████████████████████████████████████" \
  "▒▒                                              ▒▒" \
  "▒▒                Grab Source                   ▒▒" \
  "▒▒                                              ▒▒" \
  "██████████████████████████████████████████████████" && \ 
mkdir -p "/kclient" && \ 
[ -z "${KCLIENT_RELEASE:-}" ] && KCLIENT_RELEASE="$(curl -sX GET "https://api.github.com/repos/linuxserver/kclient/releases/latest" | awk '/tag_name/{print $4;exit}' FS='[""]')" && \ 
wget "https://github.com/linuxserver/kclient/archive/${KCLIENT_RELEASE}.tar.gz" --show-progress --progress=bar:force:noscroll -qO - | tar --strip-components=1 -xzC "/kclient/"

RUN \ 
printf "%s\n" "Install Node Modules" \
  "██████████████████████████████████████████████████" \
  "▒▒                                              ▒▒" \
  "▒▒           Install Node Modules               ▒▒" \
  "▒▒                                              ▒▒" \
  "██████████████████████████████████████████████████" && \ 
cd "/kclient" && \ 
npm install && \ 
rm -fv "package-lock.json"
