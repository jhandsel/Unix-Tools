# Text Processing

### Cat file, ignoring first line
```
tail -n +2 myfile
```
(start tail at line 2)

### Extract colums from tsv
Extract n'th column (1-based indexing)
```
cut -f<n> infile > outfile
```

Extract range of columns
```
cut -f<n>-<m> infile > outfile
```

### Count length of each line in file
```
awk '{print length}' infile > outfile
```

### Count number of occurrences of each line length
```
awk '{print length}' infile | sort -n | uniq -c > outfile
```
Output will have columns: num_occurrences length

### Find max line length in a file
```
awk '{print length}' infile | sort -n | tail -1
```
