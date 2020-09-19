#!/bin/bash

docker build -t cdasdsp/base-notebook-tf:latest .
docker push cdasdsp/base-notebook-tf:latest
