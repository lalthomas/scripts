# change the line ending of sh files to unix
# Lal Thomas
# 2016-05-24

for file in *.sh ; do dos2unix --force --m2d "$file"; done