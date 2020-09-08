# Anaconda
Anaconda brings a huge amount of baggage with it. Use miniconda instead.

### Add conda forge
The default instructions add conda-forge to all channels! This is a really 
bad idea, as it introduces all sorts of conflicts such as making 
tensorflow-gpu uninstallable.

Add conda forge only to current environment:
```
conda config --env --add channels conda-forge
conda config --env --set channel_priority strict
```
This creates an environment-specific `.condarc`
at `~/miniconda3/envs/myenv/.condarc`.
