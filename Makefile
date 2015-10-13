# Driver for Realtek RTS51xx USB card reader
#
# Copyright(c) 2009 Realtek Semiconductor Corp. All rights reserved.
#
# This program is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the
# Free Software Foundation; either version 2, or (at your option) any
# later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, see <http://www.gnu.org/licenses/>.
#
# Author:
#   wwang (wei_wang@realsil.com.cn)
#   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
# Maintainer:
#   Edwin Rong (edwin_rong@realsil.com.cn)
#   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
#
# Makefile for the RTS51xx USB Card Reader drivers.
#

CP ?= cp -r

MODULES = rts5139.ko
KERNEL_VERSION = $(shell uname -r)
KERNEL_DIR = /lib/modules/$(KERNEL_VERSION)
BUILD_DIR = $(KERNEL_DIR)/build
MODULES_INSTALL_DIR = $(KERNEL_DIR)/misc

obj-m := $(MODULES:.ko=.o)

ccflags-y := -Idrivers/scsi

rts5139-y :=				\
		rts51x_transport.o 	\
		rts51x_scsi.o		\
		rts51x_fop.o		\
		rts51x.o		\
		rts51x_chip.o		\
		rts51x_card.o		\
		xd.o			\
		sd.o			\
		ms.o			\
		sd_cprm.o		\
		ms_mg.o

all: modules

modules:
	$(MAKE) -C $(BUILD_DIR) M=$(PWD) modules

clean:
	$(MAKE) -C $(BUILD_DIR) M=$(PWD) clean

install: all
	$(CP) $(MODULES) $(MODULES_INSTALL_DIR)
	depmod -a

uninstall:
	$(RM) $(addprefix $(dir $(MODULES_INSTALL_DIR)),$(MODULES))
	depmod -a

.PHONY: clean install
