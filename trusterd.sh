#!/bin/sh

export LD_LIBRARY_PATH=/app/usr/lib
/app/trusterd/bin/nghttpx -k --client -f0.0.0.0,$PORT -b127.0.0.1,8080 >/dev/null 2>&1 &
/app/trusterd/bin/trusterd /app/src/conf/trusterd.conf.rb
