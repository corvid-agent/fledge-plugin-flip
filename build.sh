#!/bin/bash
set -e
swift build -c release
mkdir -p bin
cp .build/release/fledge-plugin-flip bin/fledge-plugin-flip
echo "Built bin/fledge-plugin-flip"
