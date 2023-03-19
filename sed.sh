#!/bin/bash
# Author: Alisson Guedes

for i in `grep "date.timezone = " php* -r | cut -d : -f 1` ; do sed '/America\//s/New_York/Recife/g' $i ; done
