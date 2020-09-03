# xmgrace
Sometimes you just want to bang out a plot. On some machines the command is called `grace`, others `xmgrace`.

### Create basic xy line plot
For a tsv file with two columns:
```
grace infile.tsv -hardcopy -hdevice PNG [-printfile out.png]
```
If don't specify outfile, will get  `infile.png`.

To specify X and Y max:
```
grace infile.tsv -hardcopy -hdevice PNG -pexec \
'world xmax <int>;'
'world ymax <int>;'
```

### Create a nice xy line plot
```
grace infile.tsv -hardcopy -hdevice PNG -pexec \
'xaxis label "myaxis1"; 
yaxis label "myaxis2"; 
title "myplot"; 
s0 linewidth 2; 
s0 line color 2;'
```

Line colours:
```
0: blank
1: black
2: red
3: green
4: blue
5: yellow
6: brown
7: grey
8: magenta
9: turquoise
```

### Create a nice xy scatter plot
```
grace infile.tsv -hardcopy -hdevice PNG -pexec \
'xaxis label "myaxis1"; 
yaxis label "myaxis2"; 
title "myplot"; 
s0 line pattern 0; 
s0 symbol 1; 
s0 symbol size 0.5; 
s0 symbol color 1;
s0 symbol fill 1;'
```

Symbols:
```
1: o
2: square
8: +
9: x
```

### Create error bar plot
File should have columns: X Y Yerror.
```
grace -hardcopy -hdevice PNG -pexec \
'read block "mopac.tsv";
block xydy "1:2:3";
xaxis label "myaxis1"; 
yaxis label "myaxis2"; 
title "myplot"; 
s0 line pattern 0; 
s0 symbol 1; 
s0 symbol size 0.5; 
s0 symbol color 1;
s0 symbol fill 1;'
```

### Create a plot from a parameters file
The `pexec` part can go in a file instead.
```
grace -hardcopy -hdevice PNG -printfile out.png -param infile.par
```
