#!/bin/bash
set -e

if [ "$1" == 4.0 ]
then
    SHA1=a6a35c234d324077c7819ca4ae4aa8eabaff4c15
    OUTPUT=HammerDB-4.0-Linux.tar.gz
    URL=https://github.com/TPC-Council/HammerDB/releases/download/v4.0/$OUTPUT
elif [ "$1" == 3.3 ]
then
    SHA1=3a0a7552e74c0f8cb07376301b23c6a5ca29d0f1
    OUTPUT=HammerDB-3.3-Linux.tar.gz
    URL=https://github.com/TPC-Council/HammerDB/releases/download/v3.3/$OUTPUT
else
    echo 'Expects version parameter. Supported versions: 3.3 4.0' 1>&2
    exit 1
fi

if test -f "$OUTPUT"
then
    CHECK_OUTPUT=${OUTPUT}
    echo "$OUTPUT exists, skipping download" 1>&2
else
    CHECK_OUTPUT=${OUTPUT}.tmp
    curl --location --output "$CHECK_OUTPUT" "$URL" 1>&2
fi

GZSHA1_ARRAY=($(sha1sum "$CHECK_OUTPUT"))
GZSHA1=${GZSHA1_ARRAY[0]}

if [ "$GZSHA1" != "$SHA1" ]
then
    echo "Unexpected checksum $GZSHA1" 1>&2
    echo "Expected $SHA1" 1>&2
    exit 1
fi

if ! test -f "$OUTPUT"
then
    mv "$CHECK_OUTPUT" "$OUTPUT"
fi

echo -n "$OUTPUT"
