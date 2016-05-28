# remove null characters from file
# Lal Thomas
# 2016-05-24
 
for file in *.md; do sed -i 's/\x0//g' "$file"; done
