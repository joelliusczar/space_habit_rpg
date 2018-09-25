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

function copyFiles {
    section="$1"
    fromSection=${2:-Code}

    [ ! -d ${SRCROOT}/../../SH_CP/${section} ] && mkdir -p ${SRCROOT}/../../SH_CP/${section}
    cp -r -f ${SRCROOT}/${fromSection}/ ${SRCROOT}/../../SH_CP/${section}/
}


function runMake {
    section="$1"
    pushd ${SRCROOT}/../../SH_CP/${section}
    make clean

    make
    popd
}
