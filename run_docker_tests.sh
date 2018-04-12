#!/bin/sh


docker build --tag absence_swift .
docker run -e hawkId=$hawkId -e hawkKey=$hawkKey --rm absence_swift