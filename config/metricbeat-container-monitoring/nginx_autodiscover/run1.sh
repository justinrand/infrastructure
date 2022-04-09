# expose 8800 as localhost port for this nginx server; mount a common nginx.conf (so you never need to re-build a new image)
docker run -itd --name nginx-autodiscovery-localhost -p 8802:80 -v /home/elastic/DockerConfig/nginx.conf:/etc/nginx/nginx.conf metric-docker-nginx-autodiscovery:1.0
docker ps -all | grep -i nginx-autodiscovery-localhost | awk '{print $1}'i > instance-3.id
