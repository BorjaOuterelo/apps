-include $(TOPDIR)/.config
-include $(TOPDIR)/Make.defs
include $(APPDIR)/Make.defs

MICRO_RTPS_DIR = $(APPDIR)/eprosima/micrortpsclient/micrortps-client
MICRO_RTPS_INSTALL_DIR = $(MICRO_RTPS_DIR)/build/install

ifeq ($(CONFIG_WINDOWS_NATIVE),y)
  BIN = ..\..\libapps$(LIBEXT)
else
ifeq ($(WINTOOL),y)
  BIN = ..\\..\\libapps$(LIBEXT)
else
  BIN = ../../libapps$(LIBEXT)
endif
endif

EXTRA_LIBPATHS = -L "${shell dirname "/root/apps/eprosima/micrortpsclient/micrortps-client/build/install/lib/libmicrortps-client.a"}"
EXTRA_LIBS = -l micrortps-client

all: .built
  .PHONY: clean depend distclean preconfig
  .PRECIOUS: ../../libapps$(LIBEXT)

.built: cmakecompile
	$(call DELDIR, $(MICRO_RTPS_DIR)/build/extracted)
	$(Q) mkdir $(MICRO_RTPS_DIR)/build/extracted; cd $(MICRO_RTPS_DIR)/build/extracted; arm-none-eabi-ar -x $(MICRO_RTPS_INSTALL_DIR)/lib/libmicrortps-client.a; \
		 arm-none-eabi-ar -x $(MICRO_RTPS_INSTALL_DIR)/lib/libmicrocdr.a; arm-none-eabi-ar -x $(MICRO_RTPS_INSTALL_DIR)/lib/libtransport.a
	$(Q) arm-none-eabi-ar -qc $(BIN) $(MICRO_RTPS_DIR)/build/extracted/*.obj
	#$(Q) arm-none-eabi-ar -qc $(BIN) $(MICRO_RTPS_DIR)/build/extracted/*.o
	$(Q) touch .built

cmakecompile: $(MICRO_RTPS_DIR) $(MICRO_RTPS_INSTALL_DIR)/lib/libmicrortps-client.a

$(MICRO_RTPS_DIR):
	@echo "Cloning eProsima/Micro-RTPS"	
	$(Q) git clone --recursive /root/micrortps-client

$(MICRO_RTPS_INSTALL_DIR)/lib/libmicrortps-client.a:
	$(Q) mkdir micrortps-client/build
	$(Q) cd micrortps-client/build; cmake -DCMAKE_TOOLCHAIN_FILE=$(MICRO_RTPS_DIR)/../toolchain.cmake -DCHECK_ENDIANNESS=OFF -DTHIRDPARTY=ON -DCMAKE_C_FLAGS="-I. -I/root/nuttx/include -D__PX4_NUTTX -std=c99" -DBUILD_SHARED_LIBS=OFF -DCMAKE_INSTALL_PREFIX=$(MICRO_RTPS_INSTALL_DIR) ..; remake -x install
	#$(Q) cd micrortps-client/build; cmake -DTHIRDPARTY=ON -DCMAKE_C_FLAGS="" -DBUILD_SHARED_LIBS=OFF -DCMAKE_INSTALL_PREFIX=$(MICRO_RTPS_INSTALL_DIR) ..; make install
#

context: cmakecompile

.depend:

depend: .depend

clean:
	$(call DELDIR, $(MICRO_RTPS_DIR)/build)
	$(call DELFILE, $(MICRO_RTPS_DIR)/.built)

distclean: clean
	$(call DELDIR, $(MICRO_RTPS_DIR))

preconfig:

# -include Make.dep
