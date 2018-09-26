#!/bin/sh

#  SHMaster.sh
#  
#
#  Created by Joel Pridgen on 4/27/18.
#  
fp="$SRCROOT/../../perperson.sh"
[ -e "$fp" ] && . "$fp" || echo 'did not source'
TAGS="TODO:|FIXIT:"
echo "searching ${SRCROOT} for ${TAGS}"
find "${SRCROOT}" \( -name "*.h" -or -name "*.m" -or -name "*.c" \) -print0 | xargs -0 egrep --with-filename --line-number --only-matching "($TAGS).*\$" | perl -p -e "s/($TAGS)/ warning: \$1/"
export SHFolder='SH_CP'

function copyFiles {
    section="$1"
    fromSection=${2:-Code}

    [ ! -d ${SRCROOT}/../../${section} ] && mkdir -p ${SRCROOT}/../../${section}
    cp -r -f ${SRCROOT}/${fromSection}/ ${SRCROOT}/../../${section}/
}


