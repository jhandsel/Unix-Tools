# Installing CUDA

Installing CUDA can be very confusing if your Linux distro doesn't have a pre-built
package. Hopefully this will demystify the procedure.

## The NVIDIA graphics driver
The NVIDA graphics driver is needed if you're going to be using your graphics
card to power a display. It actually includes the basic CUDA driver, 
`libcuda.so` and various utilities (including `nvidia-smi`), but not the cuda
toolkit. If this is all your library needs, you're good to go!

## Cuda Toolkit
