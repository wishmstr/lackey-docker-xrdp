build:
	docker build --platform=linux/amd64 -t lackey .

run:
	docker run --platform=linux/amd64 -it --name lackey lackey

shell:
	docker run --platform=linux/amd64 -it --rm --entrypoint=bash --name lackey-tmp lackey