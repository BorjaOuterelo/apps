-include $(TOPDIR)/.config
-include $(TOPDIR)/Make.defs
include $(APPDIR)/Make.defs

# # LVGL graphic library

# ASRCS =
# CSRCS =
# VPATH =
# DEPPATH = --dep-path .

# # LVGL Libraries

# -include ./lvgl/lv_core/lv_core.mk
# -include ./lvgl/lv_hal/lv_hal.mk
# -include ./lvgl/lv_objx/lv_objx.mk
# -include ./lvgl/lv_misc/lv_fonts/lv_fonts.mk
# -include ./lvgl/lv_misc/lv_misc.mk
# -include ./lvgl/lv_themes/lv_themes.mk
# -include ./lvgl/lv_draw/lv_draw.mk

# # Set up build configuration and environment

# WD := ${shell pwd | sed -e 's/ /\\ /g'}

# CONFIG_GRAPH_LVGL_URL ?= "https://archive.org/download/lvgl4.tar"

# LVGL_VERSION ?= 4
# LVGL_TARBALL = lvgl$(LVGL_VERSION).tar.gz
# WGET ?= wget

# LVGL_UNPACKNAME = lvgl
# UNPACK ?= tar -zxf

# LVGL_UNPACKDIR =  $(WD)/$(LVGL_UNPACKNAME)

# AOBJS = $(ASRCS:.S=$(OBJEXT))
# COBJS = $(CSRCS:.c=$(OBJEXT))

# SRCS = $(ASRCS) $(CSRCS)
# OBJS = $(AOBJS) $(COBJS)

MICRO_RTPS_DIR = $(APPDIR)/eprosima/micrortpsclient/micro-RTPS-client

ifeq ($(CONFIG_WINDOWS_NATIVE),y)
  BIN = ..\..\libapps$(LIBEXT)
else
ifeq ($(WINTOOL),y)
  BIN = ..\\..\\libapps$(LIBEXT)
else
  BIN = ../../libapps$(LIBEXT)
endif
endif

all: .built
  .PHONY: context clean depend distclean preconfig
  .PRECIOUS: ../../libapps$(LIBEXT)

.built: cmakecompile
	$(Q) mkdir /root/apps/eprosima/micrortpsclient/micro-RTPS-client/build/extracted; cd /root/apps/eprosima/micrortpsclient/micro-RTPS-client/build/extracted; ar -x ../libmicrortps-client.a; \
		 ar -x ../external/install/lib/libmicrocdr.a; ar -x ../external/install/lib/libtransport.a
	$(Q) ar -qc $(BIN) /root/apps/eprosima/micrortpsclient/micro-RTPS-client/build/extracted/*.o
	$(Q) nm $(BIN)
	$(Q) touch .built

cmakecompile: /root/apps/eprosima/micrortpsclient/micro-RTPS-client/build/libmicrortps-client.a

/root/apps/eprosima/micrortpsclient/micro-RTPS-client/build/libmicrortps-client.a:
	$(Q) mkdir micro-RTPS-client/build
	$(Q) cd micro-RTPS-client/build; cmake -DTHIRDPARTY=ON ..; make
# install:

# git clone git@github.com:eProsima/micro-RTPS-client.git TODO issues with permissions
gitclone:
	@echo "Cloning eProsima/Micro-RTPS"
	$(call DELDIR, micro-RTPS-client)
	$(Q) git clone --recursive https://github.com/eProsima/micro-RTPS-client.git
	

context: gitclone

.depend: cmakecompile
# 	$(Q) $(MKDEP) $(DEPPATH) "$(CC)" -- $(CFLAGS) -- $(SRCS) >Make.dep
# 	$(Q) touch $@

depend: .depend

clean:
	$(call DELDIR, build)
	$(call DELFILE, .built)
	$(call CLEAN)

distclean: clean
	@echo "CLEAN"
	@echo "$(MICRO_RTPS_DIR)"
	$(call DELDIR, $(MICRO_RTPS_DIR))
 	#$(call DELFILE, Make.dep)
 	#$(call DELFILE, .depend)

preconfig:

# -include Make.dep
