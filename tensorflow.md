# Tensorflow

### Install with conda
Important: make sure conda-forge channel is not activated
```
conda create -n myenv
conda activate myenv
conda install tensorflow-gpu
```
Then check the GPU is detected in python
```
from tensorflow.python.client import device_lib 
print(device_lib.list_local_devices())
```
