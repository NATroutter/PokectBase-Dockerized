#!/bin/bash

docker build --no-cache -t ghcr.io/natroutter/pocketbase:local --build-arg PB_VERSION=0.29.3 .