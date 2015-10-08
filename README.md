# gatherinfo
When i used to work with Solaris servers and Java applications on Weblogic servers, and we had incidents or issues or serious problems with them, everybody in the company related to the application ran like chickens without heads.. "Why? How do we fix it? Why? How do we know it won't happen again? Why?".. There's nothing worse than working with people with no IT knowledge and that don't know how to keep calm.

Well, where i was going. In general, the most urgent is to restablish the service, but sometimes if we do it too fast you can lose important information to know what happened. That's why a good script to gather all the information is important. It can let you "not think" at those moments, execute, and later on investigate.

This ksh script has one parameter: the PID of the weblogic process
