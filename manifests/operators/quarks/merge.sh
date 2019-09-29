#!/bin/bash

QUARKS_OP_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MANIFEST_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../.." && pwd )"
MANIFEST=${MANIFEST:-$(ls $MANIFEST_DIR/*.yml)}

bosh int $MANIFEST \
  $(ls $QUARKS_OP_DIR/*.yml | xargs -L1 echo "-o") \
  $(echo "$@" | xargs -n 1 echo "-o" | xargs)