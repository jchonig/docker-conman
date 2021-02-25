
all: build

build:
	docker build -t conman  .

test: build
	docker run -v ${PWD}/config:/config -v ${PWD}/logs:/logs -p 7890:7890 conman

# Run the container with just a bash shell
run-bash:
	docker run -it --entrypoint /bin/bash conman

# Start the container and run a bash shell
exec-bash:
	docker run -it conman /bin/bash

