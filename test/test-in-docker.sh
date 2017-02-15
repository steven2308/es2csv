#!/bin/bash
set -e

while getopts "rbv:" opt; do
    case "$opt" in
        r) runonly=1 ;;
        b) buildimage=1 ;;
        v) version=$OPTARG ;;
    esac
done
shift $((OPTIND-1))

if [ ! "$version" ]; then
    echo 'ElasticSearch version(-v) required.'
    exit 1
fi

if [[ $buildimage == 1 ]]; then
    echo "+++ Docker building build image..."
    sed -e 's/FROM elasticsearch/FROM elasticsearch:'"${version}"'/g' ./test/test-env.dockerfile | docker build --tag test-env:"${version}" -
    echo "+++ Done."
fi

if [[ $runonly == 1 ]]; then
    echo "+++ Docker running tests in docker..."
    docker run -i --rm \
           -v `pwd`:/data \
           test-env:"${version}" \
           /bin/bash -c "service elasticsearch start && cd /data  && ./test/test.sh"
    echo "+++ Done."
fi