Promtail:
Promtail is an agent which ships the contents of local logs to a private Grafana Loki instance orGrafana Cloud. It is usually deployed to every machine that has applications needed to be monitored

Usage example:
#launch promtail with your own configuration file.\
**docker run --name <<container_name>> --net=host --ipc=host --uts=host --pid=host --log-opt tag="{{.Name}}"  --security-opt=seccomp=unconfined --privileged --rm -v <<file_location_path>>/promtail-config.yaml:/opt/promtail-config.yaml -v /:/host <<promtail_image>>**

#<<file_location_path>> for windows ex: C:\Users\Armedia\Docker\promtail-config.yaml\
#<<file_location_path>> for linux ex: /home/Armedia/Docker\promtail-config.yaml

#Kindly use log output tags while creating new containers, it will help visualise logs.
#For example --log-opt tag="{{.ImageName}}/{{.Name}}/{{.ID}}"

Reference: https://docs.docker.com/config/containers/logging/log_tags/

{{.ID}}	The first 12 characters of the container ID.
{{.FullID}}	The full container ID.
{{.Name}}	The container name.
{{.ImageID}}	The first 12 characters of the container’s image ID.
{{.ImageFullID}}	The container’s full image ID.
{{.ImageName}}	The name of the image used by the container.
{{.DaemonName}}	The name of the docker program (docker).