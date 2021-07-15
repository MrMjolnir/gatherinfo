# gatherinfo
When i used to work with Solaris servers and Java applications on Weblogic servers, and we had incidents or problems with them, everybody in the company ran like chickens without heads.. "Why?? Reboot!!"

Sometimes if we restablish the service too fast, you can lose important forensic information to know what happened. That's why a good script to gather all the information is important. It can let you "not think" in a stress situation, execute, and later, investigate.

This ksh script has only one parameter: the PID of the weblogic process
