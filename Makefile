# Copyright (c) 2017 by Matthew Jacob
# All rights reserved.
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of The version 2 GNU General Public License as
#  published by the Free Software Foundation.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#
# Matthew Jacob
# Feral Software
# 253 Lowell Street
# Redwood City, CA 94062
# USA
#
# gpl at feral com
#
# The default build is for the top of tree for the linux kernel.
# We keep that locally around here in a specific place.
#
BRANCH	:=	$(shell if [ -d .git ]; then git branch|awk ' { if ($$1 == "*") print $$NF }'; fi)
ifeq (${BRANCH}, master)
KMOD	?=	/lkml/linux
KVERS   ?=	$(shell sed -e 's/^.* "//' -e 's/"//' ${KMOD}/include/generated/utsrelease.h)
SRC	:=	$(KMOD)/drivers/block/nbd.c
else
KVERS	?=      $(shell uname -r)
KMOD	?=	/lib/modules/$(KVERS)/build
endif
KARCH   ?= $(shell uname -m)
EXTRA_CFLAGS += -Werror -g

ifneq ($(KERNELRELEASE),)

obj-m := nbd.o

else

all:	modules

modules:
	$(MAKE) -s -C $(KMOD) M=$(CURDIR) $@

pkg:	all
	@$(MAKE) --no-print-directory -C pkg KVERS="${KVERS}" KMOD="${KMOD}"

clean:
	$(MAKE) -C $(KMOD) M=$(CURDIR) clean

endif
