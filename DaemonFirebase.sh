#!/bin/bash

# /etc/init.d/DaemonFirebase

### BEGIN INIT INFO
...
### END INIT INFO

case "$1" in
   start)
      echo "Starting server"
      python /usr/local/bin/DaemonFirebase.py start 
      ;;

   stop)
      echo "Stopping server"
      python /usr/local/bin/DaemonFirebase.py stop
      ;;

   restart)
      echo "Restarting server"
      python /usr/local/bin/DaemonFirebase.py restart
      ;;

   *)
      echo "Usage: /etc/init.d/DaemonFirebase.sh {start|stop|restart}"
      exit 1
      ;;
esac
exit 0