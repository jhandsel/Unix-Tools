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

### Find max line length in a file (in characters)
```
wc -L myfile
```

### Sort a tsv file on a specific field
Sort based on third column:
```
sort -k 3b,3 file > file.sorted
```

### Join two tsv files
Join on first column of each file:
```
join -1 1 -2 1 file1 file2 > outfile
```
The join column should be sorted.

### Find items in column of file1 but not in column of file 2
Show lines from file 1, where items in column 1 are not found in column 1 of file 2:
```
join -v 1 -1 1 -2 1 file1 file2 > outfile
```
The compared columns must be sorted.

### Randomly shuffle lines in file
```
shuf infile > outfile
```
