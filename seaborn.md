# Seaborn

### Use inline with jupyter notebook
```
import seaborn as sns
import matplotlib.pyplot as plt
%matplotlib inline
```

### Color Palette
Set the color palette:
```
sns.set_palette('Set2')
```
Other good palettes are 'deep', 'rocket', 'Paired', 

View a color palette:
```
sns.color_palette("Set2")
```

### Plot histogram
Basic plot:
```
ax = sns.displot(my_list, binwidth=5)
```

Specify bins:
```
ax = sns.displot(my_list, bins=range(10,100,10))
```

Set axis title:
```
ax.set_axis_labels('<x label>', '<y label>')
```

Change tick interval:
```
ticks_list = [0, 5, 10 ... ]
ax.set(xticks=ticks_list)
```

Set figure size:
```
fig.set_size_inches(10,5)
```

Put legend inside plot boundaries:
```
ax.fig.tight_layout()
```

Get current axis or (if did not save to variable):
```
ax = plt.gca()
fig = plt.gcf()
```
The object `fig` is a matplotlib figure object.
