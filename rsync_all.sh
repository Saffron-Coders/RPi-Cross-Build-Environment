#!/bin/bash

# TODO... Ask for password only once.
rsync -avz $TARGET_USR@$TARGET_IP:/lib $sysroot
rsync -avz $TARGET_USR@$TARGET_IP:/usr/include $sysroot/usr
rsync -avz $TARGET_USR@$TARGET_IP:/usr/lib $sysroot/usr
rsync -avz $TARGET_USR@$TARGET_IP:/usr/local/include $sysroot/usr/local
rsync -avz $TARGET_USR@$TARGET_IP:/usr/local/lib $sysroot/usr/local
rsync -avz $TARGET_USR@$TARGET_IP:/opt/vc $sysroot/opt
