TAG=devel
IMAGE=conman
VOLUMES= \
    -v ${PWD}/config:/config
ENV=
PORTS=-p 7890:7890

all: build

build:
	docker build -t ${IMAGE}:${TAG}  .

test: build
	docker run ${VOLUMES} ${ENV} ${PORTS} ${IMAGE}:${TAG}

# Run the container with just a bash shell
run-bash: build
	docker run ${VOLUMES} ${ENV} ${PORTS} -it --entrypoint /bin/bash ${IMAGE}:${TAG}

# Start the container and run a bash shell
exec-bash: build
	docker run ${VOLUMES} ${ENV} ${PORTS} -it ${IMAGE}:${TAG} conman /bin/bash

