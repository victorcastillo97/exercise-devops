.PHONY:
		build.image.app \
		build.image.bd \
		build.image.proxy

build.image.app:
	@ docker build  \
		-f docker/app/Dockerfile \
		-t ${IMAGE_APP} \
		. \
		--no-cache

build.image.bd:
	@ docker build  \
		-f docker/bd/Dockerfile \
		-t ${IMAGE_BD} \
		. \
		--no-cache

build.image.proxy:
	@ docker build  \
		-f docker/proxy/Dockerfile \
		-t ${IMAGE_PROXY} \
		docker/proxy/ \
		--no-cache
