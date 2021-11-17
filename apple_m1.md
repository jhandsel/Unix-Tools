# Getting common tools to work on Apple M1

### gcc compilers
As of writing none of the stable versions of gcc in Macports will compile. The only
version that works is gcc-devel (the current development branch). For compiling
C code the clang compiler included in macOS works well - but when installing a port
you must remove the gcc variant or it will first try to install gcc and fail.

If gcc is really needed (eg for gfortran), it can be installed with Homebrew.

### pip + scipy
This requires OpenBlas from Homebrew. The OpenBlas in Macports doesn't work.
Install with:

    OPENBLAS=/opt/homebrew/opt/openblas pip install scipy

### pip + scikit-learn
As of writing scikit-learn cannot be installed out of the box on Apple M1 with pip.
The developers suggest using a conda environment 
(https://scikit-learn.org/stable/install.html#installing-on-apple-silicon-m1-hardware).

However, there appears to be a workaround where you first install scipy from source
(https://github.com/scikit-learn/scikit-learn/issues/19137). In a fresh virtual
environment:

    # SciPy:
    python -m pip install --no-cache --no-use-pep517 pythran cython pybind11 gast"==0.4.0"
    pyenv rehash
    python -m pip install --no-cache --no-binary :all: --no-use-pep517 scipy"==1.7.1"

    # Scikit-Learn
    python -m pip install --no-use-pep517 scikit-learn"==0.24.2"
    
    
