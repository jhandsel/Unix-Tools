# Python's Plotting Library

## Import matplotlib
```
import matplotlib.pyplot as plt
```

## Plotting something
The usual way is to create a figure with a single axis, then
add something to the axes object.
```
fig, ax = plt.subplots()
ax.plot([1, 2, 3, 4], [1, 4, 2, 3])
```

## Create a figure with multiple axes
A 2x2 grid:
```
fig, axs = plt.subplots(2, 2)
```

## The axes object
An axes object is basically a plot. It contains 2-3 *axis* objects

## Plot multiple lines on same axes
Make a plot with three lines:
```
x = np.linspace(0, 2, 100)
fig, ax = plt.subplots()
ax.plot(x, x, label='linear')
ax.plot(x, x**2, label='quadratic')
ax.plot(x, x**3, label='cubic')
```

## Add labels and legend
The legend items come from the `label` option above.
```
ax.set_xlabel('x label')
ax.set_ylabel('y label')
ax.set_title("Simple Plot")
ax.legend()  # Add a legend.
```

## Optimize layout
Sometimes subplots aren't the same size, or legend isn't in the right place.
This can (sometimes) be solved by setting a tight layout after plotting:
```
plt.tight_layout()
```

## Specify subplot grid
Use gridspec if want a specific size ratio between subplots.
```
from matplotlib import gridspec

# generate some data
x = np.arange(0, 10, 0.2)
y = np.sin(x)

# plot it
fig = plt.figure(figsize=(8, 6)) 
gs = gridspec.GridSpec(1, 2, width_ratios=[3, 1]) 
ax0 = plt.subplot(gs[0])
ax0.plot(x, y)
ax1 = plt.subplot(gs[1])
ax1.plot(y, x)

plt.tight_layout()
```

## Template plotting function
```
def my_plotter(ax, data1, data2, param_dict):
    """
    A helper function to make a graph

    Parameters
    ----------
    ax : Axes
        The axes to draw to

    data1 : array
       The x data

    data2 : array
       The y data

    param_dict : dict
       Dictionary of kwargs to pass to ax.plot

    Returns
    -------
    out : list
        list of artists added
    """
    out = ax.plot(data1, data2, **param_dict)
    return out
```
