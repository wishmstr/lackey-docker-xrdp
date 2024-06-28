build/base:
	docker build --platform=linux/amd64 -t lackey-base -f dockerfile.base .

build/app:
	docker build --platform=linux/amd64 -t lackey-app -f dockerfile.app .

run:
	docker run --platform=linux/amd64 -it -e VNC_PASSWORD=asdfasdf -p5901:5901 --name lackey lackey-app

shell:
	docker run --platform=linux/amd64 -it --rm --entrypoint=bash --name lackey-tmp lackey-app

exec:
	docker exec -it lackey bash