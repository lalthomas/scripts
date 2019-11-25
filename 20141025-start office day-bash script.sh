#!/bin/bash
# Apps
open -a "firefox"
open -a "Momentics"
# open -a "Xcode-5-1"
open -a "thunderbird"
# open -a "todotxtmac"
# open -a "qtodotxt"

# GTD
open "birthdays.md"
open "work/todo.txt"
open "work/done.txt"
open "me/todo.txt"
open "me/done.txt"
sh "me/@schedule-to-todo.sh"
sh "me/@create-journal-file.sh"
sh "work/@schedule-to-todo.sh"
sh "work/@create-journal-file.sh"
python "/Users/rapid/Dropbox/scripts/python-simplehttpserver-with-markdown.py"
