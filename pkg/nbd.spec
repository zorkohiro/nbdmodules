Name:		nbd
Summary:	Network Block Driver
Vendor:		Feral Software
ExclusiveOS:	Linux
Group:		System Environment/Kernel
License:	GPLv2
Source0:	drivers.tar
%define debug_package  %{nil}
%define kmod_xt_path	/lib/modules/%{KVERS}/extra

Version:	%{KERNELVER}
Release:	%{KERNELREL}
AutoReq:	0

Requires:	kernel = %{KERNELDEP}
%{?el6:Requires(post):          module-init-tools}
%{?el6:Requires(postun):        module-init-tools}
%{?el7:Requires(post):          kmod}
%{?el7:Requires(postun):        kmod}

%description
This package contains the Network Block Driver (nbd)
as a separate package for adding to RedHat systems
which by default do not enable NBD either as a loaded
or as a module device.
%prep
pwd
%setup -q -c
%build
%install
%{__rm} -rf %{buildroot}
%{__mkdir} %{buildroot}
%{__install} -d %{buildroot}%{kmod_xt_path}
%{__install} -m 755 nbd.ko %{buildroot}%{kmod_xt_path}/nbd.ko
%check
%clean
pwd
rm -rf %{buildroot}
%files
%defattr(755,root,root,755)
%{kmod_xt_path}/nbd.ko
%post
depmod -a
%preun
%postun
%changelog
* Tue Jun 13 2017 Matthew Jacob <gpl@feral.com>
- Initial creation
