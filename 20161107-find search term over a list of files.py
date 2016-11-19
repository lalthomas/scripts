import re

shakes = open("tt.txt", "r")
for line in shakes:
    if re.search(r"(?i)"+'|'.join(word_lst), line):
        print line,