#!/usr/bin/python
import re
import datetime
import sys
from tempfile import mkstemp
from shutil import move
from os import remove, close

# thanks : http://stackoverflow.com/a/1745035/2182047

# parse command line
if file_name_given:
    inf = open(file_name_given)
else:
    inf = sys.stdin
    
# thanks http://stackoverflow.com/a/7034031/2182047    

for line in fileinput.input():
    process(line)
    
# thanks  : http://stackoverflow.com/a/39110/2182047

def replace(file_path, pattern, subst):
    #Create temp file
    fh, abs_path = mkstemp()
    new_file = open(abs_path,'w')
    old_file = open(file_path)
    for line in old_file:
        new_file.write(line.replace(pattern, subst))
    #close temp file
    new_file.close()
    close(fh)
    old_file.close()
    #Remove original file
    remove(file_path)
    #Move new file
    move(abs_path, file_path)



print(
    datetime.datetime.fromtimestamp(
        int("1284101485")
    ).strftime('%Y%m%d')
)
