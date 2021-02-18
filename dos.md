# MS-DOS

### Installing DOS

1. Download the floppy images from the Legacy PC Project from http://www.thelegacypcproject.com/software.html

1. The easiest way to create an image is with virtualbox.

1. Create a new virtual machine with the following settings
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

### Basic Commands
Get help for a command:
```
mycommand /?
mycommand
help mycommand
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
