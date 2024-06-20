#服务器对比实测脚本

FROM debian:12.5
MAINTAINER dujun

ADD data.txz /

RUN rm -f /etc/apt/sources.list.d/debian.sources &&\
    echo "deb http://mirrors.tencent.com/debian/ bookworm main non-free non-free-firmware contrib\ndeb-src http://mirrors.tencent.com/debian/ bookworm main non-free non-free-firmware contrib\ndeb http://mirrors.tencent.com/debian-security/ bookworm-security main\ndeb-src http://mirrors.tencent.com/debian-security/ bookworm-security main\ndeb http://mirrors.tencent.com/debian/ bookworm-updates main non-free non-free-firmware contrib\ndeb-src http://mirrors.tencent.com/debian/ bookworm-updates main non-free non-free-firmware contrib\ndeb http://mirrors.tencent.com/debian/ bookworm-backports main non-free non-free-firmware contrib\ndeb-src http://mirrors.tencent.com/debian/ bookworm-backports main non-free non-free-firmware contrib" > /etc/apt/sources.list &&\
    apt-get update -y &&\
    apt-get install php8.2 php8.2-imagick ffmpeg jpegoptim -y &&\
    sed -i "s/;date.timezone =/date.timezone = Asia\/Shanghai/g" /etc/php/8.2/cli/php.ini &&\
    mv /install/yaf.so /usr/lib/php/20220829/ && \
    mv /install/yaf.ini /etc/php/8.2/mods-available/ && \
    ln -s /etc/php/8.2/mods-available/yaf.ini /etc/php/8.2/cli/conf.d/10-yaf.ini &&\
    rm -fr /install

ENTRYPOINT php /server_testing/cli/index.php testall
