# Parse Postfix Mail Logs
I was sick of manually parsing mail logs of specific users so i built this small script to do it for me.

This script is used to fetch and parse the maillogs of two spamguards and two smtprelays to get the incoming and outgoing trafic that a specific user has generated and present a tidy readable output. 
The traffic output is based on the log entry which has the "PASSED CLEAN" tag.

If your are using SSH Keys on your servers just replace the lines relating to SCP etc.

It is probably not the best way to do this and my inconsistent use of AWK, EGREP and SED could probably be trimmed down to use only one of the three but it is working as intended so what the heck!

![arrypoah](https://i.giphy.com/media/UJS4fUKBaTc8o/giphy.gif)
