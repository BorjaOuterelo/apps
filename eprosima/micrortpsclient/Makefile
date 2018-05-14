-include $(TOPDIR)/.config
-include $(TOPDIR)/Make.defs
include $(APPDIR)/Make.defs

MICRO_RTPS_DIR = $(APPDIR)/eprosima/micrortpsclient/micro-RTPS-client
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

EXTRA_LIBPATHS = -L "${shell dirname "/root/apps/eprosima/micrortpsclient/micro-RTPS-client/build/install/lib/libmicrortps-client.a"}"
EXTRA_LIBS = -l micro-RTPS-client

all: .built
  .PHONY: clean depend distclean preconfig
  .PRECIOUS: ../../libapps$(LIBEXT)

.built: cmakecompile
	$(call DELDIR, $(MICRO_RTPS_DIR)/build/extracted)
	$(Q) mkdir $(MICRO_RTPS_DIR)/build/extracted; cd $(MICRO_RTPS_DIR)/build/extracted; arm-none-eabi-ar -x $(MICRO_RTPS_INSTALL_DIR)/lib/libmicrortps_client.a; \
		 arm-none-eabi-ar -x $(MICRO_RTPS_INSTALL_DIR)/lib/libmicrocdr.a; arm-none-eabi-ar -x $(MICRO_RTPS_INSTALL_DIR)/lib/libmicrortps_transport.a
	$(Q) arm-none-eabi-ar -qc $(BIN) $(MICRO_RTPS_DIR)/build/extracted/*.obj
	#$(Q) arm-none-eabi-ar -qc $(BIN) $(MICRO_RTPS_DIR)/build/extracted/*.o
	$(Q) touch .built

cmakecompile: $(MICRO_RTPS_DIR) $(MICRO_RTPS_INSTALL_DIR)/lib/libmicrortps_client.a

$(MICRO_RTPS_DIR):
	@echo "Cloning eProsima/Micro-RTPS"	
	$(Q) git clone --recursive https://github.com/eProsima/micro-RTPS-client.git

$(MICRO_RTPS_INSTALL_DIR)/lib/libmicrortps_client.a:
	$(Q) mkdir micro-RTPS-client/build
	$(Q) cd micro-RTPS-client/build; cmake -DCMAKE_TOOLCHAIN_FILE=$(MICRO_RTPS_DIR)/../toolchain.cmake -DCHECK_ENDIANNESS=OFF -DTHIRDPARTY=ON -DCMAKE_C_FLAGS="-I. -I/root/nuttx/include -D__PX4_NUTTX -std=c99" -DBUILD_SHARED_LIBS=OFF -DCMAKE_INSTALL_PREFIX=$(MICRO_RTPS_INSTALL_DIR) ..; make -x install
	#$(Q) cd micro-RTPS-client/build; cmake -DTHIRDPARTY=ON -DCMAKE_C_FLAGS="" -DBUILD_SHARED_LIBS=OFF -DCMAKE_INSTALL_PREFIX=$(MICRO_RTPS_INSTALL_DIR) ..; make install
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
