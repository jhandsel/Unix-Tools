# pkgsrc

Pkgsrc is a package manager from NetBSD. It provides an up-to-date repository for installing software from source. 
Binary packages are also available as an add-on from Joyent.

## 1. Install pkgsrc on Linux/MacOS

### Set prefix for duration of installation
(The exact prefix only matters if you're planning on installing binary packages from joyent's
repository, as these have a hard-coded location.)

```
export PREFIX=/usr
```

If not using Joyent's packages, you may prefer to use `PREFIX=/opt`.

### Download the source tarball
Decompress to your chosen prefix.
```
cd $PREFIX
wget http://cdn.netbsd.org/pub/pkgsrc/stable/pkgsrc.tar.xz
tar xf pkgsrc.tar.xz
```

### If installing only from source
If you aim to install everything from source, bootstrap pkgsrc from the tar archive. This
installs the pkgsrc binaries to `$PREFIX/pkg`:
```
cd pkgsrc/bootstrap
./bootstrap --abi 64 --make-jobs 4 --prefix $PREFIX/pkg --prefer-pkgsrc yes
```
- The `--abi 64` options means compile with 64 bit address space enabled. 
- The `--prefer-pkgsrc yes` option makes pkgsrc use its own libraries rather than the native
libraries already on the machine. This is the safer option, although pkgsrc will need to
compile many more libraries to get things up and running. While it is tempting to set this
option to `no`, doing so can get you into dependency hell.

### If using a binary distribution from Joyent
This is a useful option if you are having trouble compiling a specific binary.

Bootstrap with the tarball from [Joyent](https://pkgsrc.joyent.com/) to 
gain access to their binary packages. Install packages with `pkgin` according to Joyent's
website.

If you are also going to be compiling packages, you will need to edit `/usr/pkg/etc/pkg_install.conf`.
The default setup is to verify every binary with gpg. Your own compiled binaries will have no gpg key,
and the default will totally block their installation. The following change will prompt you when you
try to install unsigned binaries:
```
VERIFIED_INSTALLATION=trusted
```

Or you can turn off verification completely (use with care):
```
VERIFIED_INSTALLATION=never
```

### Add pkgsrc binary folders to path

If using `/opt` prefix:
```
export PATH=/opt/pkg/sbin:/opt/pkg/bin:$PATH
export MANPATH=/opt/pkg/man:$MANPATH
```
If using `/usr` prefix (needed when using Joyent):
```
export PATH=/usr/pkg/sbin:/usr/pkg/bin:$PATH
export MANPATH=/usr/pkg/man:$MANPATH
```

### Configure pkgsrc
Configure pkgsrc by modifying `$PREFIX/pkg/etc/mk.conf`.

The defaults are usually fine, but it's useful to set the number of make jobs: 
```
MAKE_JOBS=4
```

Fetch package vulnerabilities so that `bmake` can check them when compiling. This should be re-run periodically.
```
sudo pkg_admin fetch-pkg-vulnerabilities
```

### Use sudo for priviledge escalation
To use `sudo` instead of `su` prompt when using bmake, first install pkgsrc's sudo package,
and add your user to the sudoers (see sudo documentation).
Then add the following at the bottom of `$PREFIX/pkg/etc/mk.conf`:
```
.if exists(${LOCALBASE}/bin/sudo)
SU_CMD=        ${LOCALBASE}/bin/sudo /bin/sh -c
.endif
```

Alternatively, just point `SU_CMD` to the `sudo` that came with your distro.

## 2. Set up GCC
The default behavior in pkgsrc is to use the system's base version of gcc to
compile software. This may be a problem if your system's version of gcc is
old. NetBSD 9.0 includes GCC 7, so if your base version of gcc is older than
this you might want to upgrade the version of gcc used by pkgsrc.

If you decide to upgrade pkgsrc's version of gcc, this should be the first
thing you do. It's a very bad idea to upgrade it later. According to NetBSD's
wiki:
- While C packages can be built with mixed versions, the binary should be linked
with the higher version because the support library is backwards compatible but 
not forward compatible.
- C++ packages that are linked together should be built with the same compiler, 
because the standard library ABI is not necessarily the same for each compiler
version

First, bootstrap the desired version of GCC by compiling it with your
system-base version of GCC:

```
cd $PREFIX/pkgsrc/lang/gcc7
bmake
bmake install
```

Any dependencies will be installed in bootstrap mode, and will only be used
as dependencies for gcc.

Then, edit `$PREFIX/etc/mk.conf` and set the minimum gcc version:
```
GCC_REQD= 7
```

NOTE: when pkgsrc installs an upgraded version of GCC, it puts it at
`$PREFIX/pkg/gcc/bin`, which is not automatically added to the path. 
Pkgsrc knows to find it here, but when doing anything outside pkgsrc,
you still get the system's base version of gcc. It is not recommended
to add the new gcc to your path as the default version, as this can cause
problems with inconsistent versioning when compiling software outside of pkgsrc.

## 3. Compiling packages from source
### Basic compiling
To compile from source, use `bmake`. First find where the source is located, eg:
```
find /usr/pkgsrc -type d -iname vim
```

Then `cd` to the directory, and run
```
bmake
bmake install
```

### Updating packages (and dependencies)
Navigate to the package to update and run:
```
bmake update
```

### Checking dependencies
To show a list of dependencies for the current package:
```
bmake show-depends
```

To pre-download the necessary files for compiling the package, including dependencies:
```
bmake fetch-list | sh
```

### Setting build options
In a package's source directory:
```
bmake show-options
```

To set options, add a line to `$PREFIX/pkg/etc/mk.conf`. Options with '-' before are disabled. Eg:
```
PKG_OPTIONS.vim= python
PKG_OPTIONS.python39= -x11
```

### List installed packages
```
pkg_info
```

### Uninstall package
```
pkg_delete <package name>
```

## 4. Set up Python
### Different versions of python
Different versions are available in `$PREFIX/pkgsrc/lang/pythonXX`.

### Set default python version
In order for other packages (eg pip) to be compiled for a specific
python version, you need to set the default python version.

Add the following to `mk.conf`:
```
PYTHON_VERSION_DEFAULT=39
```

Change 39 to whatever version of python you want. When you build python modules,
`bmake` will build for the desired version of python.

### Build a package for a different version of python
It is possible to temporarily set the python version when building a package.
First clean out any previous builds of package and its dependencies:
```
bmake clean clean-depends
```

Then install for the desired version of python:
```
bmake install PYTHON_VERSION_DEFAULT=27
```

### Managing alternatives
Sometimes you want `python` to point to `python2.7` and `python3` to point
to the desired version of Python 3. This is the case in Slackware where
the default python is still 2.7 (as of Jan 2022).

If you install python3 with pkgsrc, it sets `$PREFIX/pkg/bin/python` to point
to python3. This risks causing a problem if your system expects `python` to
point to python2.

The package `pkg_alternatives` can be installed to deal with alternatives:
```
cd pkgsrc/pkgtools/pkg_alternatives
bmake
bmake install
```

On installation, pkg_alternatives initializes alternatives for python and 
any other packages with alternatives defined in their source folder.

You can list all packages that can be set as alternatives:
```
pkg_alternatives list
```

To link pkgsrc's `python` to the system version of python2:
```
pkg_alternatives -w manual bin/python /usr/bin/python2.7
```

Alternatively, both `python` and `python3` can be set to point to the
same version of python by using `pkg_alternatives` in group mode (the
default):
```
pkg_alternatives manual python39
```

To remove all links, simply uninstall `pkg_alternatives`.

### Python command line
If you want to be able to navigate the python CLI with the arrow keys, be sure to
install py-readline.

### Certificates
For python's urllib to be able to verify ssl certificates, be sure to install
`security/ca-certificates` and `security/py-certify`. The pkgsrc version of python
won't pick up on your distro's existing certificates.

## 5. Audit all pkgsrc software on machine
```
pkg_admin fetch-pkg-vulnerabilities
pkg_admin audit
```
