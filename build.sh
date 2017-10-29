#!/usr/bin/env bash
source ./mo
BUILD_MESSAGE=$'## This file is generated\n## DO NOT EDIT\n'
PHP_VERSION="7.1"

PHP_TYPE="cli"
INCLUDE_TOOLS="true"

cat Dockerfile.template | mo > ${PHP_TYPE}/Dockerfile

PHP_TYPE="fpm"
INCLUDE_TOOLS=

cat Dockerfile.template | mo > ${PHP_TYPE}/Dockerfile