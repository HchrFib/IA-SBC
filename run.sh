#!/bin/bash

if (( $# > 0 )); then
  owl2clips --input nutricion.ttl --format turtle
  echo ""
  echo ""
fi

python3 input.py | ./bin/clips
