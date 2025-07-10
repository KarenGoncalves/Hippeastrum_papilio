#!/bin/sh

echo "Database liliopsida_odb10
Species Hippeastrum-papilio" | tr " " "\t" | tr "-" " " > table_busco_result

grep 'one_line_summary' busco/short_summary.specific.liliopsida_odb10.busco.json\
 | sed -E 's/^ +//' | cut -f 2 -d ' ' |\
sed -E 's/"C:([0-9+\.]+)%\[S:([0-9\.]+)%,D:([0-9\.]+)%\],F:([0-9\.]+)%,M:([0-9\.]+)%,n:([0-9]+)",/Complete \1\nSingle \2\nDuplicated \3\nFragmented \4\nMissing \5\nn_markers \6/'\
 | tr " " "\t" >> table_busco_result
