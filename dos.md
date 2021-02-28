# MS-DOS

### Installing DOS

1. Download the floppy images from the Legacy PC Project from http://www.thelegacypcproject.com/software.html

1. The easiest way to create an image is with virtualbox. Create a new virtual machine with the following settings
    * Name: DOS
    * Type: Other
    * Version: DOS

1. Choose the default memory drive.

1. Then create a virtual hdd in VDI format, and put a fixed size smaller than 2GB.

1. For the new virtual machine, go to Settings > Storage, click on the floppy and "insert" DOS disk 1 (downloaded separately).

1. Start the machine, and press cancel when it asks for an optical drive.

1. Go through the installer, and select the correct country and keyboard layout.

1. When it asks for the next disk, right click on the floppy icon and choose the correct file.

1. After installation, remove the floppy and allow it to boot to DOS. Then insert the supplemental floppy, switch to A drive and run `setup C:\DOS`.
Select the desired packages and then choose vga.

### Image to SD card
You can then image the drive onto an SD card for use with SD-IDE converter. 

Open powershell/cmd and navigate to the VirtualBox install directory. 

```
.\vboxmanage internalcommands converttoraw ‘C:\PATH\TO\YOUR\VIRTUALDRIVE.vdi’ NameOfImage.img
```

Then use RUFUS or DD to image the .img to your SD card.

To use RUFUS, first umount the SD card
```
mountvol DRIVELETTER: /p
```
Then choose the .img in rufus and write to the disk

### Format a new system drive
This is how to copy DOS over from a boot disk.

Set up the partitions on drive C: with fdisk. Make the new partition active.

Format and copy over system files:
```
format C: /s
```

Ensure the system files were copied over:
```
sys C:
```

Then install the master boot record:
```
fdisk /mbr <drive number>
```
You can get the drive number from `fdisk /status`.
The computer should now be able to boot from drive C.

Create a directory called `DOS` on drive C.
```
md DOS
```

Then go back to the root of the boot disk, and copy over all files
```
xcopy *.* C: /S
```





### Basic Commands
Get help for a command:
```
mycommand /?
help mycommand
```

Show contents of file (like UNIX cat):
```
type myfile
type | more
```

Read file into pager:
```
more < myfile
```

### Set Permissions
Set read-only:
```
attrib +R myfile
```
Set not read-only:
```
attrib -R myfile
```
Also have A (archive), S (system file) and H (hidden file).
