DISCLAIMER
==========
Use this software at your **OWN risk**.
It is possible that under different OS/system configurations, or with different
hardware parts and laptop models, this software can permanently damage your hardware.
Always prefer original manufacturer's software (e.g. download from official 
Lenovo/Dell etc. website) unless you really know what you are doing, and you are 
willing to take the risk and try new experimental features.

UPDATE
=======
This is a backported (from kernel 4.0) version of the psmouse kernel module, with support for ALPSv7 touchpads.
With this patched module, users can drive Thinkpad 14 (and potentially T440/T440s/T440p/T/W540) using the new touchpad of 
Lenovo which brought back the physical buttons.
ALPS passthrough is now working. 

Under the 'configX11' folder, you can find the files which you need to add under your
system's '/etc/X11/xorg.conf.d'  path. First use 'xinput list' to double-check that the 
'MatchProduct' string in the X11 configuration files, matches the name of the detected 
(by your system) input devices.

UPDATE 2
========
(April 2015)
With Linux Kernel 4.0 there is naitive support for trackpoint (including scrooling ect) and touchpad (including multitouch): https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=b314acaccd7e0d55314d96be4a33b5f50d0b3344
Arch users can build and boot the linux-mainline PKGBUILD from AUR: https://bbs.archlinux.org/viewtopic.php?pid=1517933#p1517933


psmouse-dkms-alpsv7
===================

QUICK START
-----------
:loudspeaker: Make sure you have `dkms` and `linux-headers` installed in your system: :loudspeaker:
```sh
    sudo pacman -S dkms linux-headers            #for archlinux
    sudo apt-get dkms linux-headers-$(uname -r)  #for ubuntu/debian
```

Run the following commands in your shell **__as root__**:
```sh
    cd /tmp
    git clone http://github.com/he1per/psmouse-dkms-alpsv7
    cd psmouse-dkms-alpsv7
    ./install.sh
```

This will build and install the updated `psmouse` module for your current kernel.


INTRODUCTION
------------

Some new machines, like the Lenovo Ideapad Flex 15 have a new ALPS touchpad
which uses a protocol different from previous versions. The linux kernel (as of
3.13) does not recognize them as an ALPS touchpad, and they end up being
recognized only as a PS/2 mouse. For this reason there is no scrolling, no
middle button emulation, no two finger recognition, etc.

The folks at the linux kernel input devices mailing list were very helpful and
pointed me to the right patches, I have simply gathered them together and added
a dkms.conf file to make it easier to build. This page
(https://github.com/he1per/psmouse-dkms-alpsv7) explains how you install
and build the module.

Thanks specially to Tommy Will from the linux-input@vger.kernel.org mailing list
and to Elaine (Qiting) who actually wrote the code :) The original patch from 
Elaine is found here:

http://www.spinics.net/lists/linux-input/msg29084.html

DO I NEED THIS MODULE?
----------------------

If you get an error like this from `dmesg`:
```
psmouse serio1: alps: Unknown ALPS touchpad: E7=73 03 0a, EC=88 b6 06
```

then you need this module. Your touchpad will be recognized after you install it.

If you have a Toshiba Z30-A, you need to update to kernel 3.17  and you won't
need this patch.


BUILDING and INSTALLING
-----------------------

### Pre-requisites:

* __dkms__:  
    ```bash
     pacman -S dkms   #will install dkms in archlinux based distros
                      #use apt-get install dkms in debian or rpm 
                      # in redhat distros
    ```

* __linux headers__       will be installed as a dependency if you use any
  of the commands above.


### Manual build and install of psmouse.ko

It is better to use `install.sh`, but if you want to build and install
manually you can follow these instructions.

As root do the following from the directory where this README is found:
(all this is done automatically by the `install.sh` script)

```bash
    dkms add .  
    dkms build -m psmouse-dkms-alpsv7 -v 1.1  
    dkms install -m psmouse-dkms-alpsv7 -v 1.1  
    modprobe psmouse
```
