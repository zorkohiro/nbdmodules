# nbdmodules
Network Block Device packaged as module for distros (centos/rhel 6 and 7, e.g) that don't by default build them.

The idea is to build the nbd.ko for all possible released kernels as rpms so you can install them as
needed without having to rebuild and modify the kernel installed.

To build using docker, use BuildDocker.

To build otherwise, you can run on a CentOS6 system and use BuildAll to get
all CentOS6/RHEL6 rpms, ditto for a CentOS7 system for CentOS7 rpms.

To update the list of kernels to build agains, update md5sum.versions with the
md5sum of the drivers/block/nbd.c module from the source from that distro. That
should match one of the versions under versions. You can add a new one if needed.
There also may be patches which would be simpler to apply that can be found
under the patches directory.

# Limitations

These are not signed packages which has its own set of issues for installation.
