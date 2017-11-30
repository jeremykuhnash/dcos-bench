Name:           helloworld
Version:        1.0
Release:        1%{?dist}
Summary:        A hello world program

License:        GPLv3+
URL:            https://blog.packagecloud.io
Source0:        helloworld-1.0.tar.gz

Requires(post): info
Requires(preun): info

%description
A helloworld program from the packagecloud.io blog!

%prep
%setup

%build
make PREFIX=/usr %{?_smp_mflags}

%install
make PREFIX=/usr DESTDIR=%{?buildroot} install

%clean
rm -rf %{buildroot}

%files
%{_bindir}/helloworld

