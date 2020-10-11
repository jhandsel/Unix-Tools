# Formatting Disks

### Check if disk is zeroed
Check first gigabyte of disk:
```
dd if=/dev/sdX bs=1024k count=1024 of=test
hexdump test
```
If the out put is all zeros, with an asterisk under, then the first gigabyte
of the disk is zeroed.
