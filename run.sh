#!/bin/bash

SCRIPT_DIR1=$(dirname "${BASH_SOURCE[0]}")
WORK_DIR=`cd "$SCRIPT_DIR1/.." && pwd`

gobuild(){
	mkdir $WORK_DIR/builder || true

	cd $WORK_DIR
	export BUILDDIR="$WORK_DIR/builder"
	export PATH=/usr/local/opt/bison/bin/:$PATH
	export PS4='+${BASH_SOURCE}:${LINENO}:${FUNCNAME[0]}@\w@ '
	bash -x shsrc/RTBuilder_32b -g 10.2.0 -r 3+ -o buster 2> >(tee building.log)
}

set_env(){
	xdir=$(dirname $(find $WORK_DIR/builder/cross* -name as))
	export PATH=$xdir:/usr/local/opt/bison/bin/:$PATH
}

ulimit -n 1024

if [ "$1" = "env" ] ; then
	set_env
else
	gobuild
fi
