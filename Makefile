build:
	docker pull php:7.0-fpm-alpine
	docker build -t wppier/wordpress .
.PHONY: build
