#!/bin/bash

set -xe

sha="$1"
branch="$2"

if [[ $branch != "RHEL-7" ]]; then
    :
    exit $?
fi

[[ -d dracut ]] && rm -fr dracut

git clone ${branch:+-b "$branch"} https://github.com/dracutdevs/dracut.git

cd dracut

case "$sha" in
    pr:*)
	git fetch -fu origin refs/pull/${sha#pr:}/head:pr
	git checkout pr
	;;

    "")
	;;

    *)
	git checkout "$sha"
	;;
esac

yum -y install $(<test/test-rpms.txt)
