# clean:
# 	docker rm -f lackey || true

# build:
# 	docker build --platform=linux/amd64 -t lackey-app -f dockerfile.app .

# run: clean
# 	docker run --rm --platform=linux/amd64 -it -e VNC_PASSWORD=asdfasdf -p5901:5901 --name lackey lackey-app

# shell:
# 	docker run --platform=linux/amd64 -it --rm --entrypoint=bash --name lackey-tmp lackey-app

# exec:
# 	docker exec -it lackey bash

# exec/root:
# 	docker exec --user=0 -it lackey bash

artifacts/download:
	if [ ! -d .artifacts ]; then \
		mkdir -p .artifacts; \
		wget --show-progress --progress=bar:force:noscroll -q  https://lackeyccg.com/LackeyCCGWin.zip -O .artifacts/LackeyCCGWin.zip; \
		unzip .artifacts/LackeyCCGWin.zip -d .artifacts; \
	fi

build:
	docker compose build

build/nocache:
	docker compose build --no-cache

run:
	docker run -it --platform=linux/amd64 --entrypoint=bash docker-runtime-lackey

shell:
	docker compose exec -it lackey bash

up:
	docker compose up