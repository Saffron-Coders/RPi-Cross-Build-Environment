#!/bin/bash

rsync -avz misc $TARGET_USR@$TARGET_IP:/usr/local
