# Getting common tools to work on Apple M1

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
    
    
