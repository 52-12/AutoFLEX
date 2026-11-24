#!/usr/bin/env bash
# Linux port of build.sh: vendor FLEX sources, patch two std::atomic members
# that the older SDK headers reject, then package with Theos.
set -euo pipefail

rm -rf FLEX src
mkdir src
git clone --depth=1 https://github.com/FLEXTool/FLEX
find FLEX/Classes -type f \( -name "*.h" -o -name "*.m" -o -name "*.mm" -o -name "*.c" \) -exec cp {} src/ \;

FILE="src/FLEXSwiftInternal.mm"
sed -i '59s/std::atomic<mask_t> _maybeMask;/mask_t _maybeMask;/' "$FILE"
sed -i '65s/std::atomic<preopt_cache_t \*> _originalPreoptCache;/preopt_cache_t * _originalPreoptCache;/' "$FILE"

make package FINALPACKAGE=1
