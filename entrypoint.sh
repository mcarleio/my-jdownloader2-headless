#!/bin/sh

# Endless restart loop
while sleep 10 && /start.sh; do
  echo ""
done