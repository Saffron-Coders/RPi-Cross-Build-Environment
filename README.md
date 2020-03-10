# RPi-Cross-Build-Environment
An automated cross compilation environment used for cross compiling programs for the Raspbian OS.

*** Details of the DevEnv filesystem ***

DevEnv
  |
  |-- Packages : Downloads directory for all packages required for building the Aura projects.
  |
  |-- misc : Directory for sync to the target device. This will contain the output binary and lib files
  |          that are cross-built in the host machine and synced to the target device separately. Packages, libs
  |          and tools which are installed in the target device itself are synced to sysroot.
  |
  |--|-- bin : Contains binaries from miscellaneous packages.
     |
     |-- include : Contains extracted header files. This directory may contain down heirarchies too.
     |
     |-- lib : Contains extracted library files. The extracted libraries must be manually copied to this
     |         directory directory. It is recommended not to keep sub-tree for different packages. The goal
     |         is to keep all the lib files here in the same directory so that its easier for linkers to find.
     |
  |-- sysroot : System directories from target device are synced here. Used for cross building projects.
  |
  |--|--usr
     |--|--local
        |--|--misc : Symbolic link to ../../misc. (Create this file manually)
  |-- boost,poco,etc... : Some optional directories for packages. These are not part of the main filesystem technically.
  |                These are just developers folders.
  |
  |-- rsync_all.sh : Script to sync the sysroot directory from the target device.
  |
  |-- rsync_misc.sh : Script to sync the misc directory to the target device.
  
*** Guide to setup the development environment ***

1. Create the above mentioned directory tree, except the 4th one.

2. Set IP address of target and run rsync_all.sh. The IP can be set in the file itself.

3. In target device, create a directory /usr/local/misc and set owner to leo:pi or whatever username it is in future:
   $ sudo mkdir /usr/local/misc
   $ sudo chown leo:pi /usr/local/misc

4. Run the script rsync_misc.sh.

5. In target device, run the following commands:
   $ echo "/usr/local/misc/lib" | sudo tee /etc/ld.so.conf.d/misc.conf
   $ sudo ldconfig
   
   --- You are good to go now ---

*** Points to remember
1. Always run the following command after rsync_all.sh:
	$ ./sysroot-relativelinks.py sysroot
