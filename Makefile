build: build/fake-build-product

build/fake-build-product: Dockerfile $(shell find files)
	docker pull php:7.0-fpm-alpine
	docker build -t wppier/wordpress .
	touch build/fake-build-product

.PHONY: build
