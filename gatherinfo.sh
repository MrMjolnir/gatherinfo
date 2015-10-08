#!/bin/ksh

# Parameter --> Weblogic PID. Or no parameter needed if we adapt a little bit the "ps" command below..
#

EMAILTO=address1,address2
WLUSER="weblogic"

echo "[Executing script, it can take some minutes...]"
echo "[Be patient...]"
echo ""

DATESTAMP=`/bin/date +%m%d%y-%H%M`
mkdir -p log/$DATESTAMP
cd log/$DATESTAMP

# system stats and infos
/usr/bin/netstat -an > netstat.out.$DATESTAMP &
/usr/bin/iostat -xen > iostat.out.$DATESTAMP &
/usr/bin/vmstat 5 24 > vmstat.out.$DATESTAMP &
/usr/bin/prstat -Lcp $PID 5 24 > prstat.out.$DATESTAMP &
/usr/bin/mpstat 5 24 > mpstat.out.$DATESTAMP &
/usr/local/bin/lsof -p $PID > lsof.out.$DATESTAMP
/usr/bin/pfiles $PID > pfiles.out.$DATESTAMP
/usr/bin/pmap $PID > pmap.out.$DATESTAMP
/usr/bin/pldd $PID > pldd.out.$DATESTAMP
/usr/platform/sun4u/sbin/prtdiag > prtdiag.out.$DATESTAMP
/usr/sbin/psrinfo -v > psrinfo.out.$DATESTAMP

# Java thread dumps pstacks
# You can modify times and number of times that you execute the dumps

# Get Weblogic PID
ps -eaf -o ruser,pid,args | grep -i $WLUSER | grep "java"| grep -v grep > tmpx
while read ruser pid rest
do
  echo "[A thread dump is going to be launched on the process run by the user $ruser with PID $pid]"
  /usr/bin/pstack $pid > pstack1.out.$DATESTAMP
  kill -3 $PID
  sleep 60
  DATESTAMP=`/bin/date +%m%d%y-%H%M`
  #/usr/bin/pstack $pid > pstack2.out.$DATESTAMP
  kill -3 $PID
  sleep 60
  DATESTAMP=`/bin/date +%m%d%y-%H%M`
  #/usr/bin/pstack $pid > pstack3.out.$DATESTAMP
  kill -3 $PID
  sleep 5
done < tmpx
rm tmpx

# Copy of the Weblogic logs and of the application with problems
tar -cvf logs-weblogic.tar *
gzip *.tar
# You can send an email with the file or with a link to the file
ls -al | egrep "/*.gz" |awk '{print $9}' > tmpx
while read file_name rest
 do
 echo ""
 echo " [File $file_name is being sent...]"
 echo ""
 uuencode $file_name $file_name | mailx -s "Problema Weblogic Aplicacion X" $EMAILTO
done < tmpx
rm tmpx
