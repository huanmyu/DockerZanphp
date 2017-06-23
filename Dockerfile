FROM ubuntu:16.04

ADD . /resources

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
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

RUN tar -zxvf /resources/curl-7.54.1.tar.gz  \
    && cd /resources/curl-7.54.1/ \
    && ./configure \
    && make \
    && make install

RUN tar -zxvf /resources/openssl-1.0.2l.tar.gz \
    && cd /resources/openssl-1.0.2l/ \
    && ./config \
    && make \
    && make install

RUN tar -zxvf /resources/php-7.1.6.tar.gz \
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

RUN mv /resources/php.ini /usr/local/lib/ \
    && mv /resources/composer.phar /usr/local/bin/composer

RUN mkdir /zan \
    && cd /zan \
    && git clone https://github.com/youzan/zan-installer.git
    && cd zan-installer
    && composer install
