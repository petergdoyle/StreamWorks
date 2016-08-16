#!/bin/sh

flume-ng agent -n flume1 -c conf -f flume.conf -Dflume.root.logger=INFO,console
