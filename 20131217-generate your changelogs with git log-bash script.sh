#!/bin/bash

# # # # # # # # # # # # # # # # # # # # # # # ## # # # # # # # # # # # # # # # # # # # # #
#                                                                                        #  
#  generates change log between v2.1.0. and v2.1.1 with #changelog in the commit message #
#                                                                                        #
#  source                                                                                #
#  https://coderwall.com/p/5cv5lg                                                        #
#                                                                                        #
# # # # # # # # # # # # # # # # # # # # # # # ## # # # # # # # # # # # # # # # # # # # # #

git log v2.1.0...v2.1.1 --pretty=format:'<li> <a href="http://github.com/jerel/<project>/commit/%H">view commit &bull;</a> %s</li> ' --reverse | grep "#changelog"


# # # # # # # # # # # # # # # # # # # # # # # ## # # # # # # # # # # # # # # # # # # # # #
#                                                                                        #  
#  Generate a changelog between the v1 and v2 tags                                       #
#                                                                                        #
#  source:                                                                               #
#  http://www.commandlinefu.com/commands/view/12420/generate-a-change-log-with-git #     #
#                                                                                        #
# # # # # # # # # # # # # # # # # # # # # # # ## # # # # # # # # # # # # # # # # # # # # #

git log --no-merges --format="%an: %s" v1..v2

