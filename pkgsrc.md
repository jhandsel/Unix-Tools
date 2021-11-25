# pkgsrc

Pkgsrc is a package manager from NetBSD. It provides an up-to-date repository for installing software from source. 
Binary packages are also available as an add-on from Joyent.

## Install pkgsrc on Linux/MacOS

### Set prefix for duration of installation
(The exact prefix only matters if you're planning on installing binary packages from joyent's
repository, as these have a hard-coded location.)

macOS:
```
export PREFIX=/opt
```

Linux:
macOS:
```
export PREFIX=/opt
```

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
The `--abi 64` options means compile with 64 bit address space enabled. 
The `--prefer-pkgsrc yes` option makes pkgsrc use its own libraries rather than the native
libraries already on the machine.

### If using a binary distribution from Joyent
Bootstrap with the tarball from [Joyent](https://pkgsrc.joyent.com/) to 
gain access to their binary packages. Install packages with `pkgin` according to Joyent's
website.

If you are also going to be compiling packages, you will need to edit `$PREFIX/pkg/etc/pkg_install.conf`.
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

For macOS:
```
export PATH=/opt/pkg/sbin:/opt/pkg/bin:$PATH
export MANPATH=/opt/pkg/man:$MANPATH
```
For Linux:
```
export PATH=/usr/pkg/sbin:/usr/pkg/bin:$PATH
export MANPATH=/usr/pkg/man:$MANPATH
```

### Configure pkgsrc
Configure pkgsrc by modifying `$PREFIX/pkg/etc/mk.conf`. (The defaults are normally fine.)

Fetch package vulnerabilities so that `bmake` can check them when compiling. This should be re-run periodically.
```
sudo pkg_admin fetch-pkg-vulnerabilities
```

### Use sudo for priviledge escalation
To use `sudo` instead of `su` prompt when using bmake, first install pkgsrc's sudo package, and add your user to the sudoers (see sudo documentation).
Then add the following at the bottom of `$PREFIX/pkg/etc/mk.conf`:
```
.if exists(${LOCALBASE}/bin/sudo)
SU_CMD=        ${LOCALBASE}/bin/sudo /bin/sh -c
.endif
```

## Compile packages from source
To compile from source, use `bmake`. First find where the source is located, eg:
```
find /usr/pkgsrc -type d -name vim
```

Then `cd` to the directory, and check the build options:
```
bmake show-options
```

To set options, add a line to `$PREFIX/pkg/etc/mk.conf`. Options with '-' before are disabled. Eg:
```
PKG_OPTIONS.vim= python -ruby
```

To show a list of dependencies for the current package:
```
bmake show-depends
```

(OPTIONAL) To pre-download the necessary files for compiling the package, including dependencies:
```
bmake fetch-list | sh
```

Then make the package and install:
```
bmake
bmake install
```

## Audit all pkgsrc software on machine
```
sudo pkg_admin fetch-pkg-vulnerabilities
pkg_admin audit
```
