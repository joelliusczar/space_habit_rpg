#!/bin/sh

#	SHMaster.sh
#	
#
#	Created by Joel Pridgen on 4/27/18.
#	
fp="$SRCROOT/../../perperson.sh"
skip=1

export SHFolder='SH_CP'

function copyFiles {
	fromSection="$1"
	section="$2"

	[ ! -d ${SRCROOT}/../../${section} ] && mkdir -p ${SRCROOT}/../../${section}
	cp -r -f ${SRCROOT}/${fromSection}/ ${SRCROOT}/../../${section}/
}

function markTodo {
	
	TAGS="TODO:|FIXIT:"
	echo "searching ${SRCROOT} for ${TAGS}"
	find "${SRCROOT}" \( -name "*.h" -or -name "*.m" -or -name "*.c" \) -print0 | xargs -0 egrep \
	--with-filename --line-number --only-matching "($TAGS).*\$" | perl -p -e "s/($TAGS)/ warning: \$1/"
}

[ -e "$fp" ] && . "$fp" || echo 'did not source'

if [ -z "$skip" ]; then
	markTodo
fi
