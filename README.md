# Docker Machine
## Create docker host on Digital Ocean droplet
```
docker-machine create \
        --driver digitalocean \
        --digitalocean-access-token $DO_TOKEN \
        --engine-install-url "https://releases.rancher.com/install-docker/19.03.9.sh" \
        dockerhost;
```

## List configuration as environment variables
docker-machine env dockerhost

## Configure shell
eval $(docker-machine env dockerhost)

# Docker
## Build image from code
`docker build -t image_name .`

## Create container from image
`docker run -d -p 80:5000 --name container_name image_name`

## Docker login
`docker login`

## Tag image
`docker image tag old_name new_name:tag`

## Push image to Docker Hub
`docker push image_name:tag`