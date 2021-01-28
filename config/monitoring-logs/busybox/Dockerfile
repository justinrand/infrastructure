FROM busybox

COPY  counter.sh /
#send as parameter the path to store the log files
CMD  ./counter.sh /proc/self/fd/1 /proc/self/fd/2
