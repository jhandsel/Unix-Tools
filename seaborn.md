# Seaborn
Seaborn is built upon matplotlib. It has two ways of plotting:
* Figure level (creates figure automatically)
* Axis level (should define plot first)

I find the axis level is more predictable and controlable.

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
Palettes to try:
* tab10
* deep
* rocket
* rocket_r (reversed)
* Paired
* Set2
* viridis
* flare
* dark

View a color palette:
```
sns.color_palette("Set2")
```

Custom color palette:
```
my_palette = sns.color_palette('Blues')
my_palette.append("#FF0B04")
```
This has a gradation of blues with red at the end.
You can pop or append items as you like to fit the length of 
the palette to the plot.

### Plot histogram (axis level)
Define a figure with one axis (subplot) object:
```
f, ax = plt.subplots(figsize=(6,5))
```
The `ax` object is a matplotlib `AxesSubplot` instance corresponding to the empty axes.

Add a plot:
```
sns.histplot(df, x="Age", hue="Condition", multiple='stack', bins=range(10,100,10), 
            hue_order=['stroke', 'delirium', 'misc', 'CNS/PNS'])
plt.show()
```
The `ax` object now corresponds to the histogram (but is still a `AxesSubplot` object).

Make the plot fill up the whole 6x5 area:
```
f.tight_layout()
```

### Plot lineplot with averaging within group (axis level)
```
sns.lineplot(x="week",
             y="cumulative deaths", 
             hue='year group', 
             palette='rocket_r', 
             estimator='mean', 
             ci='sd',
             data=df)
```
The dataframe `df` must have columns 'week', 'cumulative deaths' and 'year group'. 
The `hue` option determines which group is averaged over.

### Reorder legend
```
handles, labels = ax.get_legend_handles_labels()
order = list(range(0, len(labels)))
order.reverse()
plt.legend([handles[idx] for idx in order],[labels[idx] for idx in order])
plt.show()
```

### Turn off scientific number notation
```
ax.ticklabel_format(axis='y', style='plain')
```

### Add commas to y tick labels
```
ax.yaxis.set_major_formatter(plt.matplotlib.ticker.StrMethodFormatter('{x:,.0f}'))
```

### Change y tick intervals
```
ax.set_yticks(range(0, 105, 5))
```

### Plot histogram (figure level)
Basic plot:
```
g = sns.displot(my_list, binwidth=5)
```
The `g` is a SeaBorn FacetGrid object.

Specify bins:
```
g = sns.displot(my_list, bins=range(10,100,10))
```

Set axis title:
```
g.set_axis_labels('<x label>', '<y label>')
```

Change tick interval:
```
ticks_list = [0, 5, 10 ... ]
g.set(xticks=ticks_list)
```

Set figure size:
```
g.fig.set_size_inches(10,5)
```

Put legend inside plot boundaries:
```
g.fig.tight_layout()
```

### Get matplotlib figure/axes
Get current axis or (if did not save to variable):
```
fig = plt.gcf()
ax = plt.gca()
```
The object `fig` is a matplotlib figure object.
