
all: build

build:
	docker build -t conman  .

test: build
	docker run -v ${PWD}/config:/config -v ${PWD}/logs:/logs -p 7890:7890 conman
