#!/bin/bash

pip install -q .
while ! echo exit | curl -s localhost:9200; do sleep 10; done
pushd ./test
curl -s -XPOST localhost:9200/logstash-12.12.2012/log/_bulk --data-binary @<(sed 's/^/{"index": {}}\n&/' es_docs.json) | jq .
bats smoke.bats