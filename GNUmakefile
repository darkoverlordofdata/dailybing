#
# GNUmakefile - Generated by ProjectCenter
#
ifeq ($(GNUSTEP_MAKEFILES),)
 GNUSTEP_MAKEFILES := $(shell gnustep-config --variable=GNUSTEP_MAKEFILES 2>/dev/null)
endif
ifeq ($(GNUSTEP_MAKEFILES),)
 $(error You need to set GNUSTEP_MAKEFILES before compiling!)
endif

include $(GNUSTEP_MAKEFILES)/common.make

#
# DailyBing
#
VERSION = 1.0.0
PACKAGE_NAME = DailyBing
APP_NAME = DailyBing
DailyBing_APPLICATION_ICON = DailyBing.png


#
# Resource files
#
DailyBing_RESOURCE_FILES = \
Resources/imageCache.plist \
Resources/avatar.png  \
Resources/catlock.png  \
Resources/catlock.py  \
Resources/DailyBing.png
#
# Header files
#
DailyBing_HEADER_FILES = \
Source/DBWindow.h \
Source/DBDataIndex.h \
Source/DBImageView.h \
Source/AppDelegate.h \
Source/NSImage+SaveAs.h \
Source/ResourceManager.h

#
# Class files
#
DailyBing_OBJC_FILES = \
Source/main.m \
Source/DBWindow.m \
Source/DBDataIndex.m \
Source/DBImageView.m \
Source/AppDelegate.m \
Source/NSImage+SaveAs.m \
Source/ResourceManager.m

OBJC_LIBS+= -ldispatch

#
# Makefiles
#
-include GNUmakefile.preamble
include $(GNUSTEP_MAKEFILES)/aggregate.make
include $(GNUSTEP_MAKEFILES)/application.make
-include GNUmakefile.postamble
