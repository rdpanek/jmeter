#!/bin/bash -e

JMETER_VERSION=5.3.0

docker build --tag="rdpanek/jmeter:${JMETER_VERSION}" .
docker build --tag="rdpanek/jmeter:vnc-${JMETER_VERSION}" -f ./vnc/Dockerfile .