# update and upgrade
sudo apt-get update
sudo apt-get upgrade
sudo apt-get autoremove
sudo apt-get autoclean

# install stuff
sudo apt-get install git
sudo apt-get install sshfs
sudo apt-get install sshpass
sudo apt-get install docker.io
sudo apt-get install docker-compose

# mount storagebox
USERNAME="username"
PASSWORD="password"
HOSTNAME="${USERNAME}.your-storagebox.de"
REMOTE_PATH="/"
LOCAL_MOUNT_POINT="$HOME/hetzner_storage"

mkdir -p "$LOCAL_MOUNT_POINT"

# mount storagebox with password
sshpass -p "$PASSWORD" sshfs "${USERNAME}@${HOSTNAME}:${REMOTE_PATH}" "$LOCAL_MOUNT_POINT"
mkdir -p "$LOCAL_MOUNT_POINT/Movies"

# install qBittorrent
sudo add-apt-repository ppa:qbittorrent-team/qbittorrent-stable
sudo apt-get update
sudo apt-get install qbittorrent

# install jellyfin
curl https://repo.jellyfin.org/install-debuntu.sh | sudo bash

# install flaresolverr
docker run -d \
  --name=flaresolverr \
  -p 8191:8191 \
  -e LOG_LEVEL=info \
  --restart unless-stopped \
  ghcr.io/flaresolverr/flaresolverr:latest

# install radarr and prowlarr
curl -o servarr-install-script.sh https://raw.githubusercontent.com/Servarr/Wiki/master/servarr/servarr-install-script.sh
chmod +x servarr-install-script.sh
./servarr-install-script.ssh radarr prowlarr

# install jellyseerr
docker run -d \
  --name jellyseerr \
  -e LOG_LEVEL=debug \
  -e TZ=Europe/Brussels \
  -e PORT=5055 \
  -p 5055:5055 \
  -v /etc/jellyseerr/config:/app/config \
  --restart unless-stopped \
  fallenbagel/jellyseerr

# cleanup
rm servarr-install-script.sh

# reboot
echo "Rebooting is recommended. Do you want to reboot now? (y/n)"
read -r REBOOT
if [ "$REBOOT" == "y" ]; then
    sudo reboot
fi