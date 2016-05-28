# change the line ending of sh files to unix
# Lal Thomas
# 2016-05-24

# replace ending of all sh files to unix
for file in *.sh ; do dos2unix --force --d2u "$file"; done

# replace ending of all md files to windows
for file in *.md ; do dos2unix --force --u2d "$file"; done
