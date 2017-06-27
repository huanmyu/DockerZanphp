FROM phusion/baseimage:0.9.22

RUN mkdir /resources

ADD ./resources /resources

RUN apt-get update \
    && apt-get install -y \
    autoconf                         \
    libkrb5-dev                      \
    libc-client2007e                 \
    libc-client2007e-dev             \
    libcurl4-openssl-dev             \
    libbz2-dev                       \
    libjpeg-dev                      \
    libmcrypt-dev                    \
    libxslt1-dev                     \
    libxslt1.1                       \
    libpq-dev                        \
    libpng12-dev                     \
    libfreetype6-dev                 \
    build-essential                  \
    git                              \
    make

RUN tar -zxvf /resources/curl-7.54.1.tar.gz -C /resources  \
    && cd /resources/curl-7.54.1/ \
    && ./configure \
    && make \
    && make install

RUN tar -zxvf /resources/openssl-1.0.2l.tar.gz -C /resources \
    && cd /resources/openssl-1.0.2l/ \
    && ./config \
    && make \
    && make install

RUN tar -zxvf /resources/php-7.1.6.tar.gz -C /resources \
    && cd /resources/php-7.1.6/ \
    && ./configure \
    --with-zlib-dir                              \
    --with-freetype-dir                          \
    --enable-mbstring                            \
    --with-libxml-dir=/usr                       \
    --enable-soap                                \
    --enable-calendar                            \
    --with-curl                                  \
    --with-mcrypt                                \
    --with-zlib                                  \
    --with-gd                                    \
    --disable-rpath                              \
    --enable-inline-optimization                 \
    --with-bz2                                   \
    --with-zlib                                  \
    --enable-sockets                             \
    --enable-sysvsem                             \
    --enable-sysvshm                             \
    --enable-pcntl                               \
    --enable-mbregex                             \
    --enable-exif                                \
    --enable-bcmath                              \
    --with-mhash                                 \
    --enable-zip                                 \
    --with-pcre-regex                            \
    --with-pdo-mysql                             \
    --with-mysqli                                \
    --with-mysql-sock=/var/run/mysqld/mysqld.sock \
    --with-jpeg-dir=/usr                         \
    --with-png-dir=/usr                          \
    --enable-gd-native-ttf                       \
    --with-openssl                               \
    --with-fpm-user=www-data                     \
    --with-fpm-group=www-data                    \
    --enable-ftp                                 \
    --with-imap                                  \
    --with-imap-ssl                              \
    --with-kerberos                              \
    --with-gettext                               \
    --with-xmlrpc                                \
    --with-xsl                                   \
    --enable-opcache                             \
    --enable-fpm                                 \
    && make \
    && make install

RUN git clone https://github.com/youzan/zan.git /resources/zan \
    && cd /resources/zan/zan-extension/ \
    && phpize \
    && ./configure --enable-sockets --enable-async-redis  --enable-openssl \
    && make \
    && make install \
    && git clone --recursive --depth=1 https://github.com/kjdev/php-ext-lz4.git /resources/php-ext-lz4 \
    && cd /resources/php-ext-lz4 \
    && phpize \
    && ./configure \
    && make \
    && make install

RUN mv /resources/php.ini /usr/local/lib/ \
    && mv /resources/composer.phar /usr/local/bin/composer

RUN mkdir /zan \
    && git clone https://github.com/youzan/zan-installer.git /zan/zan-installer \
    && cd /zan/zan-installer \
    && composer install

CMD ["/sbin/my_init"]

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /resources
