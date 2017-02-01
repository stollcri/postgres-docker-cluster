DOCKER_IMAGE_TAG ?= latest
DOCKER_IMAGE_PGSQL ?= postgresql-cluster-pgsql
DOCKER_IMAGE_PGPOOL ?= postgresql-cluster-pgpool
DOCKER_LOCAL_REGISTRY ?= localhost

default: publish
publish: build publish-post-build
build: build-pgsql build-pgpool
publish-post-build: publish-post-build-pgsql publish-post-build-pgpool

build-pgsql:
	docker build -t $(DOCKER_IMAGE_PGSQL) -f Pgsql.Dockerfile .
publish-post-build-pgsql:
	docker tag $(DOCKER_IMAGE_PGSQL):$(DOCKER_IMAGE_TAG) $(DOCKER_LOCAL_REGISTRY)/$(DOCKER_IMAGE_PGSQL):$(DOCKER_IMAGE_TAG)
	docker push $(DOCKER_LOCAL_REGISTRY)/$(DOCKER_IMAGE_PGSQL):$(DOCKER_IMAGE_TAG)

build-pgpool:
	docker build -t $(DOCKER_IMAGE_PGPOOL) -f Pgpool.Dockerfile .
publish-post-build-pgpool:
	docker tag $(DOCKER_IMAGE_PGPOOL):$(DOCKER_IMAGE_TAG) $(DOCKER_LOCAL_REGISTRY)/$(DOCKER_IMAGE_PGPOOL):$(DOCKER_IMAGE_TAG)
	docker push $(DOCKER_LOCAL_REGISTRY)/$(DOCKER_IMAGE_PGPOOL):$(DOCKER_IMAGE_TAG)
