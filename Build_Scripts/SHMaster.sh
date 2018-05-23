#!/bin/sh

#  SHMaster.sh
#  
#
#  Created by Joel Pridgen on 4/27/18.
#  
fp="$SRCROOT/../../perperson.sh"
[ -e "$SRCROOT/../../$fp" ] && . "$fp"

TAGS="TODO:|FIXIT:"
echo "searching ${SRCROOT} for ${TAGS}"
find "${SRCROOT}" \( -name "*.h" -or -name "*.m" \) -print0 | xargs -0 egrep --with-filename --line-number --only-matching "($TAGS).*\$" | perl -p -e "s/($TAGS)/ warning: \$1/"
