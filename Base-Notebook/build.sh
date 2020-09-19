#!/bin/bash

docker build -t cdasdsp/base-notebook:cuda-11 .
docker push cdasdsp/base-notebook:cuda-11