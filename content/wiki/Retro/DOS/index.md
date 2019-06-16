DOS
===

## DOS GAMES

[Games](dos-games.md)

http://dosprograms.info.tt/indexall.htm#links

https://www.bootdisk.com/usb.htm


## CDEMU CDROM Emulator

http://files.mpoli.fi/unpacked/hardware/cdrom/other/


## DOSBOX

Create empty floppy image

 head -c 1474560 /dev/zero > myimage.vfd

Source: https://superuser.com/questions/342433/how-to-create-an-empty-floppy-image-with-virtualbox-windows-guest

---

mount C  /Users/dfreniche/Desktop/MSDOS

Unmount drive A

mount -U A

---

[autoexec]
# Lines in this section will be run at startup.
# You can put your MOUNT lines here.

mount c: e:\dosbox
mount d d:\ -t cdrom
mount a: a:\


---

HJSplit

http://hjsplit.org/dos/