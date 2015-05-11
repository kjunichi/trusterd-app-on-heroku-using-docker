FROM heroku/cedar:14

RUN useradd -d /app -m app
RUN chown app:app -R /app

WORKDIR /app

ENV HOME /app
ENV PORT 3000

# install mruby
WORKDIR /app
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update
RUN apt-get -y install git libmagick++-dev libcurl4-openssl-dev autoconf automake autotools-dev libtool \
pkg-config zlib1g-dev libcunit1-dev libssl-dev libxml2-dev rake \
libevent-dev libjansson-dev libjemalloc-dev cython python3.4-dev libev-dev
RUN cd /usr/local/src/ && git clone --depth 1 https://github.com/h2o/qrintf.git
RUN cd /usr/local/src/qrintf && make install PREFIX=/usr/local
USER app
RUN cd /app && git clone --depth 1 git://github.com/matsumoto-r/trusterd.git
RUN cd /app/trusterd && make
#&& make install INSTALL_PREFIX=/app/trusterd
RUN cp /app/trusterd/mruby/build/host/mrbgems/mruby-http2/nghttp2/src/nghttpx /app/trusterd/bin/nghttpx
RUN mkdir -p /app/usr/lib/
RUN cd /usr/lib/x86_64-linux-gnu/ && cp libMagick++.so.5 libMagick++.so.5.0.0 /app/usr/lib
RUN cd /usr/lib/x86_64-linux-gnu/ && cp libevent-2.0.so.5 libevent_openssl-2.0.so.5 libevent_core-2.0.so.5 /app/usr/lib
RUN cd /usr/lib/x86_64-linux-gnu/ && cp libjemalloc.so.1 libev.so.4 /app/usr/lib
RUN cp /usr/local/bin/qrintf /app/trusterd/bin/qrintf
RUN cd /app/trusterd && make clean
EXPOSE 3000

ONBUILD RUN mkdir -p /app/src
ONBUILD WORKDIR /app/src
ONBUILD COPY ./build_config.rb /app/trusterd/build_config.rb
ONBUILD WORKDIR /app/trusterd
ONBUILD RUN make
ONBUILD COPY . /app/src
