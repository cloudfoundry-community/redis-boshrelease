#!/bin/bash

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
QUARKS_OP_DIR=$ROOT/quarks/operations
MANIFEST_DIR=$ROOT/manifests
MANIFEST=${MANIFEST:-$(ls $MANIFEST_DIR/*.yml)}

bosh int $MANIFEST \
  $(ls $QUARKS_OP_DIR/*.yml | xargs -L1 echo "-o") \
  $(echo "$@" | xargs -n 1 echo "-o" | xargs)