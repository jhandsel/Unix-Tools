# Text Processing

### Cat file, ignoring first line
```
tail -n +2 myfile
```
(start tail at line 2)

### Extract colums from tsv
Extract 5th column (1-based indexing)
```
cut -f5 infile > outfile
```

Extract range of columns (inclusive)
```
cut -f5-7 infile > outfile
```

Extract set of columns
```
cut -f2,3,8 infile > outfile
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

### Combine two single-column files into tsv
```
paste file1 file2 > outfile
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
Shuffle all of file
```
shuf infile > outfile
```

Extract 1000 lines, shuffled
```
shuf -n 1000 infile > outfile
```

### Extract specific line from file
Extract 25th line:
```
sed -n '25p' myfile
```
For very large file (several GB), head/tail is faster:
```
head -25 myfile | tail -1
```

### Delete unwanted lines from file
```
sed '/<regex>/d' infile > outfile
```
