# expose 8800 as localhost port for this nginx server; mount a common nginx.conf (so you never need to re-build a new image)
docker run -itd --name nginx-standalone-1 -p 8800:80 -v /home/elastic/DockerConfig/nginx.conf:/etc/nginx/nginx.conf metric-docker-nginx-standalone:1.0
docker ps -all | grep -i metric-docker-nginx-standalone:1.0 | grep -i nginx-standalone-1 | awk '{print $1}'i > instance2.id
