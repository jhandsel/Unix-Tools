# Pandas

### Create dataframe from lists
```
df = pd.DataFrame(list(zip(lst, lst2)), columns =['<name 1>', '<name 2>'])
```

### Select subsample of dataframe
Randomly select 100 rows
```
df2 = df.sample(n=100)
```
Randomly select 60% of data
```
df2 = df.sample(frac=0.6)
```
