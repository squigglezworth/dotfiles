#!/bin/bash
#echo "$@" > ~/test
mpc search any "$1" | shuf | shuf | mpc add
