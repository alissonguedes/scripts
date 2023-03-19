#!/bin/bash
# Author: Alisson Guedes

find /home/*/*/ -type f -name "*.txt" \( -exec grep "hacked by w.to" {} \; -a -exec ls -l {} \; \) | awk '{print $9}' > deletar.txt

