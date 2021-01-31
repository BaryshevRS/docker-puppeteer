#!/bin/sh

docker build -t vnc .
docker run --rm -it -v $(pwd):/app/ -p 5900:5900 vnc
