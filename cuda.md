# Installing CUDA

Installing CUDA can be very confusing if your Linux distro doesn't have a pre-built
package. Hopefully this will demystify the procedure. Some software (eg TensorFlow)
requires very specific versions of the cuda toolkit and cudNN, so check which
version you need.

## The NVIDIA graphics driver
The NVIDA graphics driver is needed if you're going to be using your graphics
card to power a display. It actually includes the basic CUDA driver, 
`libcuda.so` and various utilities (including `nvidia-smi`), but not the cuda
toolkit. If this is all your library needs, you're good to go!

This driver is not needed for headless machines.

## Cuda Toolkit
The cuda toolkit binary (eg `cuda_11.5.1_495.29.05_linux.run`) contains:
- NVIDIA driver
- CUDA driver `libcuda.so`
- CUDA toolkit (compilers, C extensions...)

If you're going to be using your graphics card purely for computing in a 
headless machinne, this binary is all you need to get started.
```
sh cuda_11.5.1_495.29.05_linux.run --silent --toolkit --driver
```

The `--silent` flag is needed on some systems as the installer fails to
run ncurses properly.

If you have installed the NVIDIA graphics driver, you can choose to install
just the toolkit. It's a good idea to run `nvidia-smi` to check which version
of the cuda driver is installed so you can match it with the toolkit version.
```
sh cuda_11.5.1_495.29.05_linux.run --silent --toolkit
```

Alternatively, you can use the same command as installing on a headless node.
It will detect if the nvidia graphics driver is already installed, and remove
it before continuing. You can check the install/uninstall logs at:
```
less /var/log/nvidia-installer.log
less /var/log/nvidia-uninstall.log

## cudNN
The cudNN library is needed to run deep learning frameworks like
TensorFlow. You need to sign up for NVIDIA's developer network
to download it. It comes as a tarball that needs to be
decompressed into the location specified by NVIDIA.
