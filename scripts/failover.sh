#!/bin/bash

set -e

if [ -z "$1" ]; then
  echo "Usage: ./failover.sh <secondary-region>"
  exit 1
fi

SECONDARY=$1

./scripts/deploy.sh $SECONDARY

echo "Failover completed. Resources deployed in $SECONDARY."
