#!/bin/bash 
## cleanup old Journal files

journalctl --flush
journalctl --rotate
journalctl --vacuum-time=1s
journalctl --vacuum-size=10M
