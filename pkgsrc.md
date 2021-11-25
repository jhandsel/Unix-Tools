# Install pkgsrc on Linux/MacOS

Pkgsrc is a package manager from NetBSD. It provides an up-to-date repository for installing software from source. 
Binary packages are also available as an add-on from Joyent.

1. Download pkgsrc tarball and decompress to `PREFIX=/opt` for Macos or `PREFIX=/usr` for Linux.
(The exact folder only matters if you're planning on installing binary packages from joyent's
repository, as these have a hard-coded location.)
```
cd $PREFIX
wget http://cdn.netbsd.org/pub/pkgsrc/stable/pkgsrc.tar.xz
tar xf pkgsrc.tar.xz
```

2. If you aim to install everything from source, bootstrap pkgsrc from the tar archive:
```
cd pkgsrc/bootstrap
./bootstrap --abi 64 --make-jobs 4 --prefix $PREFIX/pkg --prefer-pkgsrc yes
```
The `--abi 64` options means compile with 64 bit address space enabled. 
The `--prefer-pkgsrc yes` option makes pkgsrc use its own libraries rather than the native
libraries already on the machine.

3. Alternatively, bootstrap with the tarball from [Joyent](https://pkgsrc.joyent.com/) to 
gain access to their binary packages. Install packages with `pkgin` according to Joyent's
website.

4. Add new paths to shell startup files

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

5. Configure pkgsrc by modifying `$PREFIX/pkg/etc/mk.conf`. (The defaults are normally fine.)
