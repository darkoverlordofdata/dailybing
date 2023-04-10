#!/usr/bin/bash

. /usr/GNUstep/System/Library/Makefiles/GNUstep.sh
export RUNTIME_VERSION=gnustep-2.1
export CXXFLAGS="-std=c++11"
gmake install