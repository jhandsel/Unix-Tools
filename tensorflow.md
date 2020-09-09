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
### Tensorboard
After the model has been compiled, add a callback to tensorboard:
```
log_dir = "logs/fit/" + datetime.datetime.now().strftime("%Y%m%d-%H%M%S")
tensorboard_callback = tf.keras.callbacks.TensorBoard(log_dir=log_dir, histogram_freq=1)

model.fit(x=x_train, 
          y=y_train, 
          epochs=5, 
          validation_data=(x_test, y_test), 
          callbacks=[tensorboard_callback])
```
If don't want a histogram after every epoch, remove the `histogram_freq` option.

To share tensorboard on local network:
```
tensorboard --logdir logs/fit --bind_all
```
Tensorboard will look for logs in directory `logs/fit`
```
