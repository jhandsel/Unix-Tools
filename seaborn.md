# Seaborn

### Use inline with jupyter notebook
```
import seaborn as sns
import matplotlib.pyplot as plt
%matplotlib inline
```

### Plot histogram with automatic binning
```
ax = sns.displot(my_list, binwidth=5)
ax.set_axis_labels('<x label>', '<y label>')
```

### Change tick interval
```
ticks_list = [0, 5, 10 ... ]
ax.set(xticks=ticks_list)
```

### Set figure size
```
fig = plt.gcf()
fig.set_size_inches(10,5)
```
The object `fig` is a matplotlib figure object.
