

run:
	docker build -t test . && docker run -it test

run-ghcr:
	docker run -it --pull always ghcr.io/matgoebl/test:latest /bin/bash
