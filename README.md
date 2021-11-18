

# This worked
podman run -p 7070:8888 openresty/openresty:1.11.2.3-xenial

Within the openresty container, there was no netstat. Instead checked the `/proc/<PID>/net/tcp` to see what port it was listening on

PID of the nginx process:
```
root@b47b70266cca:/# ps -ef
UID          PID    PPID  C STIME TTY          TIME CMD
root           1       0  0 05:14 ?        00:00:00 nginx: master process /usr/local/openresty/bin/openresty -g daemon off;
nobody         2       1  0 05:14 ?        00:00:00 nginx: worker process
root           3       0  0 05:14 pts/0    00:00:00 /bin/sh
root          11       3  0 05:16 pts/0    00:00:00 bash
root          21      11  0 05:16 pts/0    00:00:00 ps -ef
```

Now that we know that PID of the nginx master is 1, we can just use that info:
```
root@7c61ce4b2e9b:/# cat /proc/1/net/tcp
  sl  local_address rem_address   st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode
   0: 00000000:22B8 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 18368 1 0000000000000000 100 0 0 10 0

```

# Use the app.lua and nginx.conf

docker  run --rm  -it  -p 7070:8888  -v $(pwd)/app.lua:/tmp/app.lua -v $(pwd)/nginx.conf:/usr/local/openresty/nginx/conf/nginx.conf   openresty/openresty:1.11.2.3-xenial


Using docker because I could not get podman working with bind mounts.
Most likely this issue:
https://github.com/containers/podman/issues/8302


