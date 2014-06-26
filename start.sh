#!/bin/bash

# Apps
open -a "thunderbird"
open -a "Xcode-5-1"
open -a "firefox"

# GTD

cd Dropbox/do
open "birthdays.md"
open "todo.txt"
open "next-action-list.txt"
open "planner-for-days-of-2014.md"
open "standup report-2014.md"
python  /Users/rapidvalue/Dropbox/scripts/python-simplehttpserver-with-markdown.py 
