# 
#  Copyright (c) 2017 by Matthew Jacob
#  All rights reserved.
# 
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of The version 2 GNU General Public License as
#   published by the Free Software Foundation.
# 
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
# 
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
# 
#  Matthew Jacob
#  Feral Software
#  253 Lowell Street
#  Redwood City, CA 94062
#  USA
# 
#  gpl at feral com
# 
ROOTDIR	:= $(shell dirname $(CURDIR))
KVERS   ?= $(shell uname -r)
KARCH	?= $(shell uname -m)
TARFILE	:= drivers.tar
RPMDIRS	:= BUILD SPECS RPMS SRPMS SOURCES BUILDROOT
BINARIES:= nbd.ko
FILES	:= nbd.spec

HASSEP	:= $(shell echo $(KVERS) | grep '-')

ifeq ($(HASSEP),)
KERNELVER := $(KVERS)
KERNELREL := 0.1
KERNELDEP := $(KVERS)
else
KERNELVER := $(shell echo $(KVERS) | sed "s/-.*$$//")
KERNELREL := $(shell echo $(KVERS) | sed -e "s/$(KERNELVER)-//" | sed -e "s/-.*$$//" -e "s/\.$(KARCH)//")
KERNELDEP := $(shell echo $(KVERS) | sed -e "s/\.$(KARCH)//")
endif

all:	dist

${RPMDIRS}:
	@mkdir -p $@

dist:	${RPMDIRS}
	@tar -c -f ${TARFILE} -C . $(FILES) -C $(ROOTDIR) $(BINARIES)
	@rpmbuild --quiet --define "_topdir $(CURDIR)" --define "KVERS $(KVERS)" \
		--define "KERNELVER $(KERNELVER)" \
		--define "KERNELREL $(KERNELREL)" \
		--define "KERNELDEP $(KERNELDEP)" -ta ${TARFILE}

clean:
	@rm -rf ${RPMDIRS} ${TARFILE}
