#!/usr/bin/env bash

if [[ $CONDA_DEFAULT_ENV == base || $CONDA_DEFAULT_ENV == "" ]]; then
	echo "conda activate first"
	exit 1
fi

cd $CONDA_PREFIX/share/RepeatMasker
# Move the original file aside so that conda sees no changes to the file
# (shared via hardlinks) when checking packages
mv Libraries/RepeatMasker.lib{,.orig}
# Now we'll create a new file under that name, isolated from conda's usual sharing
./util/buildRMLibFromEMBL.pl Libraries/RepeatMaskerLib.embl > Libraries/RepeatMasker.lib
# adapted from https://bioinformatics.stackexchange.com/q/14634/4980
echo -e "\n2\n$(dirname $(which rmblastn))\n\n5\n" | ./configure
