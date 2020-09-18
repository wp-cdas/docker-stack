#!/bin/bash

docker build -t cdasdsp/scipy-notebook:latest .
docker push cdasdsp/scipy-notebook:latest