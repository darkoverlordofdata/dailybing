#   GNUmakefile
#
include $(GNUSTEP_MAKEFILES)/common.make

OBJCFLAGS += -Wall

#
# We are creating a bundle
#
BUNDLE_NAME = Clock
BUNDLE_INSTALL_DIR = $(GNUSTEP_LIBRARY)/Bundles/LockWindow
$(BUNDLE_NAME)_OBJC_FILES = $(wildcard *.m)
$(BUNDLE_NAME)_PRINCIPAL_CLASS = Clock
$(BUNDLE_NAME)_RESOURCE_FILES = $(wildcard *.tiff) $(wildcard *.icns) $(wildcard *.png)
-include GNUmakefile.preamble

-include GNUmakefile.local

include $(GNUSTEP_MAKEFILES)/bundle.make

-include GNUmakefile.postamble

