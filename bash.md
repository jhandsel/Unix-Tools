# Bash Scripting

### For loop
Loop through 1 to 10 inclusive:
```
for i in $(seq 1 1 10)
do
  echo $i
done
```
First argument is initial, second argument is
optional increment, last argument is final

Loop through zero-padded numbers
```
for i in $(seq -w 1 10)
do
  echo $i
done
```

### Split a file into shards
For 10 shards:
```
for i in $(seq -w 0 9)
do 
  awk "NR%10==${i}" infile > shard${i}
done
```
NOTE: the 10th line will be in shard0

### Interleave shards into a single file
```
paste -d '\n' shard0 shard1 shard2 > combined
```
