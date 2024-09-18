# update packages
sudo apt-get update
sudo apt-get upgrade
sudo apt-get autoremove
sudo apt-get autoclean

# update flaresolverr
docker stop flaresolverr && docker rm flaresolverr
docker pull ghcr.io/flaresolverr/flaresolverr
docker run -d \
  --name=flaresolverr \
  -p 8191:8191 \
  -e LOG_LEVEL=info \
  --restart unless-stopped \
  ghcr.io/flaresolverr/flaresolverr:latest

# update jellyseerr
docker stop jellyseerr && docker rm Jellyseerr
docker pull fallenbagel/jellyseerr
docker run -d \
  --name jellyseerr \
  -e LOG_LEVEL=info \
  -e TZ=Europe/Brussels \
  -e PORT=5055 \
  -p 5055:5055 \
  -v /etc/jellyseerr/config:/app/config \
  --restart unless-stopped \
  fallenbagel/jellyseerr